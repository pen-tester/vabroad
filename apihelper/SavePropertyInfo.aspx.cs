using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public class JsonResult
{
    public int status { get; set; }
    public string result { get; set; }
    public string error { get; set; }
    public List<AmenityInfo> amenity_list { get; set; }
    public string attractions { get; set; }
    public string room_furniture { get; set; }
    public int propid { get; set; }
    public PropertyDetailInfo propinfo { get; set; }
    public JsonResult()
    {
        status = -1;
        result = ""; error = "";
        propinfo = new PropertyDetailInfo();
    }


}

public partial class userowner_SavePropertyInfo : CommonPage
{
    protected PropertyDetailInfo propinfo;
    List<AmenityInfo> amenity_list = new List<AmenityInfo>();
    DataSet ds_allattraction;

    public int propid = -1;
    public int[] hotel_type = { 8, 2, 5, 16, 11, 24, 2, 19, 22, 12 };
    public string error_msg = "";
    public int error_occured = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "application/json; charset=utf-8";
        JsonResult jsonresult = processRequest();

        Response.Write( JsonConvert.SerializeObject(jsonresult, Formatting.Indented));
        Response.End();
    }
    
    public JsonResult processRequest()
    {
        JsonResult jsonresult = new JsonResult();
        if (!AuthenticationManager.IfAuthenticated || !User.Identity.IsAuthenticated)
        {
            jsonresult.error = "Not Signed";
            return jsonresult;
        }
        else if (HttpContext.Current.Request.HttpMethod != "POST")
        {
            jsonresult.error = "The function works in POST method";
            return jsonresult;
        }
        //else{}  //If the user is signed
        
        if (!Int32.TryParse(Request["propid"], out propid)) propid = -1;

         //Validate parameters from the request
        int wizard_step = -1;
        if (!Int32.TryParse(Request["wizardstep"], out wizard_step)) wizard_step = -1;
        if(wizard_step == -1)
        {
            jsonresult.error = "Wizard Step is not set.";
            return jsonresult;
        }
        if (!ValdateWizardStep(wizard_step))  //Valdation for step parameters by step number
        {
            jsonresult.error = "Wizard Step is not set.";
            return jsonresult;
        }

        if (wizard_step == 0 && (propid == -1 || propid == 0))
        {
                propid = createNewProperty();
                if (propid == -1)
                {
                    jsonresult.error = "Server something wrong error: get new property id";
                    return jsonresult;
                }
        }
        else //For the existed property
        {
            if (propid == -1 || propid == 0)
            {
                jsonresult.error = "Server something wrong error: step is not 0, and propid is -1";
                return jsonresult;
            }
            propinfo = AjaxProvider.getPropertyDetailInfo(propid);
            if (propinfo.UserID != userid  && !AuthenticationManager.IfAdmin)
             {
                 jsonresult.error = "You are trying to do malicious action. Property doesn't include to you.";
                 return jsonresult;
             }
            if (UpdatePropertyInfo(wizard_step) == -1)
            {
                jsonresult.error = "Server something wrong error: update property info step "+ wizard_step;
                return jsonresult;
            }
        }

        List<SqlParameter> param = new List<SqlParameter>();
        if (propid > 0)
        {
            propinfo = AjaxProvider.getPropertyDetailInfo(propid); //Get the property id
            jsonresult.propinfo = propinfo;
            if (wizard_step == 1) {
                param.Add(new SqlParameter("@propid", propid));
                amenity_list = MainHelper.getListFromDB<AmenityInfo>("uspGetPropertyAmenity", param);
                jsonresult.amenity_list = amenity_list;
                param.Clear();
                param.Add(new SqlParameter("@propid", propid));
                jsonresult.room_furniture = CommonProvider.getJsonStringFromDs(BookDBProvider.getDataSet("uspGetRoomFurnitures", param));
            }
            else if(wizard_step == 2)
            {
                param.Clear();
                param.Add(new SqlParameter("@propid", propid));
                jsonresult.attractions = CommonProvider.getJsonStringFromDs(BookDBProvider.getDataSet("uspGetPropertyAttractionByID", param));
            }
        }

        jsonresult.propid = propid;
        if(propid == propinfo.ID) jsonresult.status = 0;
        return jsonresult;
    }
    //Validate the paramters
    public bool ValdateWizardStep(int step)
    {
        return true;
    }

    public int UpdatePropertyInfo(int step)
    {
        if (step == 0)
        {
            try
            {
                List<SqlParameter> param = getParamListBasicInfo(propid);
                if(param==null || CommonProvider.getScalarValueFromDB("uspUpdatePropertyBasic", param) == -1) return -1;
            }
            catch(Exception ex)
            {
                throw ex;
                return -1;
            }
        }else if(step == 1) //Amenities
        {
            try
            {
                List<SqlParameter> param = getParamListDescriptionInfo(propid);
                if (param == null || CommonProvider.getScalarValueFromDB("uspUpdatePropertyDescriptionAmenity", param) == -1) return -1;
                if (UpdateAmenityInfo() == -1)
                {
                    return -1;
                }
                if (!hotel_type.Contains(propinfo.CategoryID))  //If the rental type
                {
                    if (UpdateRoomInfo() == -1)
                    {

                    }
                }
            }
            catch(Exception ex)
            {
                throw ex;
                return -1;
            }
        }else if(step == 2)
        {
            try
            {
                List<SqlParameter> param = getParamListLocalAttraction(propid);
                CommonProvider.getScalarValueFromDB("uspUpdatePropertyAttraction", param);
                if (UpdateLocalAttraction() == -1)
                {
                    return -1;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }else if (step == 3)
        {
            try
            {
                List<SqlParameter> param = getParamRates(propid);
                CommonProvider.getScalarValueFromDB("uspUpdatePropertyRates", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        return 0;
    }

     
    public int createNewPropertyType(int catetype, string newtype)
    {
        int res = -1;
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@catid", catetype));
        param.Add(new SqlParameter("@type", newtype));
        res = CommonProvider.getScalarValueFromDB("uspAddPropertyType", param);
        return res;
    }
    public int createNewCity(int stateid, string newcity)
    {
        int res = -1;
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@stateid", stateid));
        param.Add(new SqlParameter("@city", newcity));
        res = CommonProvider.getScalarValueFromDB("uspAddCity", param);
        return res;
    }

    public int createNewProperty()
    {
        int newid = CommonProvider.getScalarValueFromDB("uspGetPropertyMaxID", new List<SqlParameter>()) + 1;
        if (newid == 0) return -1;
        try
        {
            List<SqlParameter> param = getParamListBasicInfo(newid);
            if(param==null || CommonProvider.getScalarValueFromDB("uspAddPropertyBasic", param) == -1) return -1;

        } catch(Exception ex) {
            throw ex;
            return -1;
        }
        return newid;
    }
    public List<SqlParameter> getParamListBasicInfo(int newid)
    {
        List<SqlParameter> param = new List<SqlParameter>();
        try {
            if (Request["citylist"].ToString() == "0")
            {
                string newcity = Request["additionalcity"];
                int stateid = int.Parse(Request["statelist"]);
                int newcityid = createNewCity(stateid, newcity);
                if (newcityid == -1) return null;
                param.Add(new SqlParameter("@CityID", newcityid));

                if(Request["statename"]!=null && Request["countryname"] != null)
                {
                    LatLongInfo latinfo = MainHelper.getCityLocation(newcity, Request["statename"].ToString(), Request["countryname"].ToString());
                    if (latinfo.status == 0) //Fail to get location info
                    {
                        error_msg = String.Format("Fail to get {0} location.", newcity);
                    }
                    else if (latinfo.status == 1) //Fail to verify the address
                    {
                        error_msg = String.Format("Fail to verify the location of {0}.", newcity);
                    }
                    else  //Success to get the latitude and longitude
                    {
                        try
                        {
                            //Update
                            List<SqlParameter> tmpparam = new List<SqlParameter>();
                            tmpparam.Add(new SqlParameter("@stateid", stateid));
                            tmpparam.Add(new SqlParameter("@city", newcity));
                            tmpparam.Add(new SqlParameter("@lat", latinfo.latitude));
                            tmpparam.Add(new SqlParameter("@lng", latinfo.longitude));
                            BookDBProvider.getDataSet("uspAddLatLong", tmpparam);
                        }
                        catch
                        {
                            error_msg = "Something is wrong.";
                        }

                    }
                }
 
            }
            else
            {
                param.Add(new SqlParameter("@CityID", Request["citylist"]));
            }
            
            param.Add(new SqlParameter("@ID", newid));
            param.Add(new SqlParameter("@UserID", userid));
           // param.Add(new SqlParameter("@UserID", 7332));
            param.Add(new SqlParameter("@Name", Request["_propname"]));
            param.Add(new SqlParameter("@Name2", Request["_propname2"]));
            param.Add(new SqlParameter("@VirtualTour", Request["_virttour"]));
            param.Add(new SqlParameter("@Address", Request["_propaddr"]));
            param.Add(new SqlParameter("@IfShowAddress", Request["_propdisplay"]));
            param.Add(new SqlParameter("@NumBedrooms", Request["_propbedroom"]));
            param.Add(new SqlParameter("@NumBaths", Request["_propbathrooms"]));
            param.Add(new SqlParameter("@NumSleeps", Request["_propsleep"]));
            param.Add(new SqlParameter("@MinimumNightlyRentalID", Request["_propminrental"]));
            param.Add(new SqlParameter("@NumTVs", Request["_proptv"]));
            param.Add(new SqlParameter("@NumVCRs", 0));
            param.Add(new SqlParameter("@NumCDPlayers", Request["_propcd"]));
            param.Add(new SqlParameter("@DateAdded", DateTime.Now));
            param.Add(new SqlParameter("@DateStartViewed", DateTime.Now));

                string newtype = Request["additional_type"];
                int categorytype = int.Parse(Request["propcategory"]);
                int newtypeid = createNewPropertyType(categorytype, newtype);
                if (newtypeid == -1) return null;
                param.Add(new SqlParameter("@TypeID", newtypeid));
        }
        catch(Exception ex)
        {
            throw ex;
            return null;
        }
        return param;
    }

    public List<SqlParameter> getParamListDescriptionInfo(int _propid)
    {
        List<SqlParameter> param = new List<SqlParameter>();
        
        param.Add(new SqlParameter("@ID", _propid));
        param.Add(new SqlParameter("@Description", Request["_propdescription"].ToString().Replace(Environment.NewLine,"<br />")));
        param.Add(new SqlParameter("@Amenities", Request["_propamenitytxt"].ToString().Replace(Environment.NewLine, "<br />")));
        return param;
    }
    //
    public List<SqlParameter> getParamListLocalAttraction(int _propid)
    {
        List<SqlParameter> param = new List<SqlParameter>();

        param.Add(new SqlParameter("@propid", _propid));
        param.Add(new SqlParameter("@attract", Request["_propattract"]));
        return param;
    }
    public List<SqlParameter> getParamRates(int _propid)
    {
        List<SqlParameter> param = new List<SqlParameter>();

        param.Add(new SqlParameter("@propid", _propid));
        param.Add(new SqlParameter("@minrate", Request["minrate"]));
        param.Add(new SqlParameter("@highrate", Request["hirate"]));
        param.Add(new SqlParameter("@currency", Request["currency"]));
        param.Add(new SqlParameter("@cancel", Request["cancel"]));
        param.Add(new SqlParameter("@deposite", Request["deposit"]));
        param.Add(new SqlParameter("@ratetxt", Request["rates"]));
        return param;
    }
    public int UpdateAmenityInfo()
    {
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@propid", propid));
        List<AmenityInfo> amenity_list = MainHelper.getListFromDB<AmenityInfo>("uspGetPropertyAmenity", param);
        List<string> amenity_arr = new List<string>();
        foreach(AmenityInfo amenity in amenity_list)
        {
            amenity_arr.Add(amenity.AmenityID.ToString());
        }

        char[] spliter = { ',' };
        if(Request["propamenity"]!=null && Request["propamenity"].ToString() != "")
        {
            string[] amenityval = Request["propamenity"].ToString().Split(spliter);
            //Check updated amenity id
            foreach (string req_amenity in amenityval)
            {
                if (!amenity_arr.Contains(req_amenity)) //New amenity id
                {
                    param.Clear();
                    param.Add(new SqlParameter("@propid", propid));
                    param.Add(new SqlParameter("@amenityid", req_amenity));
                    CommonProvider.getScalarValueFromDB("uspUpdatePropertyAmenityID", param); //if return value = -1 error
                }
                else //Existed amenity  
                {
                    amenity_arr.Remove(req_amenity);
                }
            }
        }

        //For removed amenity id
        foreach(string removed_amenity in amenity_arr)
        {
            param.Clear();
            param.Add(new SqlParameter("@propid", propid));
            param.Add(new SqlParameter("@amenityid", removed_amenity));
            param.Add(new SqlParameter("@method", 1));
            CommonProvider.getScalarValueFromDB("uspUpdatePropertyAmenityID", param); //if return value = -1 error
        }

        return 0;
    }
    List<string> roomid_list = new List<string>();
    List<RoomInfoFurniture> room_furniture_list = new List<RoomInfoFurniture>();
    public int UpdateRoomInfo()
    {   //Get Current room info
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@propid", propid));
        DataSet ds_roomfurniture =BookDBProvider.getDataSet("uspGetRoomFurnitures", param);

        roomid_list.Clear();
        room_furniture_list.Clear();

        if (ds_roomfurniture.Tables.Count > 0)
        {
            foreach (DataRow row in ds_roomfurniture.Tables[0].Rows)
            {
                if (!roomid_list.Contains(row["RoomID"].ToString()))  //if existed roomid
                {
                    roomid_list.Add(row["RoomID"].ToString());
                }
                RoomInfoFurniture tmp = new RoomInfoFurniture();
                tmp.RoomID = row["RoomID"].ToString();
                tmp.FurnitureItemID = row["FurnitureItemID"].ToString();
                if (!room_furniture_list.Contains(tmp))
                {
                    room_furniture_list.Add(tmp);
                }
            }
        }
        //For requested room infos
        char[] spliter = { ',' };

        if (Request["_roomids"]!=null && Request["_roomids"].ToString() != "")
        {
            string[] req_roomid_list = Request["_roomids"].ToString().Split(spliter);
            string[] req_roomnames = Request["_roomnames"].ToString().Split(new char[] { ',' });
            int index = 0;
            foreach (string req_roomid in req_roomid_list)
            {
                string req_roomname = req_roomnames[index++];
                if (roomid_list.Contains(req_roomid))//For existed room , furniture changes
                {
                    //Update RoomTitle
                    param.Clear();
                    param.Add(new SqlParameter("@id", req_roomid));
                    param.Add(new SqlParameter("@title", req_roomname));
                    param.Add(new SqlParameter("@method", 2)); //update method
                    CommonProvider.getScalarValueFromDB("uspUpdateRoomInfo", param); //if return value = -1 error

                    UpdateFurnitureID(Request["room" + req_roomid].ToString(), req_roomid);

                    roomid_list.Remove(req_roomid);
                }
                else // New Room Info
                {
                    param.Clear();
                    param.Add(new SqlParameter("@title", req_roomname));
                    param.Add(new SqlParameter("@propid", propid));
                    param.Add(new SqlParameter("@method", 0)); //add method 
                    string newroomid = CommonProvider.getScalarValueFromDB("uspUpdateRoomInfo", param).ToString(); //if return value = -1 error
                    UpdateFurnitureID(Request["room" + req_roomid].ToString(), newroomid);
                }
            }
        }

        //For removed room info and furniture changes;
        foreach (string removed_roomid in roomid_list)
        {
            param.Clear();
            param.Add(new SqlParameter("@id", removed_roomid));
            param.Add(new SqlParameter("@method", 1)); //delete method 
            string newroomid = CommonProvider.getScalarValueFromDB("uspUpdateRoomInfo", param).ToString();
        }
        foreach(RoomInfoFurniture removed_furniture in room_furniture_list)//Removed furniture changes;
        {
            if (removed_furniture.FurnitureItemID != null && removed_furniture.FurnitureItemID != "")
            {
                param.Clear();
                param.Add(new SqlParameter("@roomid", removed_furniture.RoomID));
                param.Add(new SqlParameter("@furid", removed_furniture.FurnitureItemID));
                param.Add(new SqlParameter("@method", 1));
                CommonProvider.getScalarValueFromDB("uspUpdatePropertyFurnitureID", param); //if return value = -1 error
            }
        }
        return 0;
    }

    public int UpdateFurnitureID(string req_room_str, string req_roomid)
    {
        List<SqlParameter> param = new List<SqlParameter>();
        string[] req_room_furnitures = req_room_str.Split(new char[] { ',' });
        foreach(string req_room_furnitureid in req_room_furnitures)
        {
            int index = 0;
            foreach(RoomInfoFurniture tmp_fur in room_furniture_list)
            {
                if(tmp_fur.RoomID==req_roomid && tmp_fur.FurnitureItemID == req_room_furnitureid)
                {
                    room_furniture_list.RemoveAt(index);
                    break;
                }
                index++;
            }
            if(index == room_furniture_list.Count)//New furniture
            {
                if (req_room_furnitureid != "")
                {
                    param.Clear();
                    param.Add(new SqlParameter("@roomid", req_roomid));
                    param.Add(new SqlParameter("@furid", req_room_furnitureid));
                    CommonProvider.getScalarValueFromDB("uspUpdatePropertyFurnitureID", param); //if return value = -1 error
                }
            }
        }
        return 0;
    }

    public int UpdateLocalAttraction()
    {
        List<_AttractionInfo> list_attractionobjects = new List<_AttractionInfo>();
        List<string> list_cur_attracts = new List<string>();

        List<SqlParameter> param = new List<SqlParameter>();
        param.Clear();
        param.Add(new SqlParameter("@propid", propid));
        DataSet ds_attraction = BookDBProvider.getDataSet("uspGetPropertyAttractionByID", param);
        if (ds_attraction.Tables.Count > 0)
        {
            foreach (DataRow row in ds_attraction.Tables[0].Rows)
            {
                _AttractionInfo tmp = new _AttractionInfo();
                tmp.attrid = row["AttractionID"].ToString();
                tmp.distanceid = row["DistanceID"].ToString();
                list_attractionobjects.Add(tmp);
                list_cur_attracts.Add(tmp.attrid);
            }
        }

        ds_allattraction = BookDBProvider.getDataSet("uspGetAllAttraction", new List<SqlParameter>());
        List<string> list_attraction = new List<string>();
        foreach(DataRow row in ds_allattraction.Tables[0].Rows)
        {
            list_attraction.Add(row["ID"].ToString());
        }

        if (Request["attractids"] != null && Request["attractids"].ToString() != "")
        {
            string[] req_attractionids = Request["attractids"].ToString().Split(new char[] { ',' });
            string[] req_attractnear = Request["attract_near"].ToString().Split(new char[] { ',' });
            foreach (string req_attractid in req_attractionids)
            {
                int index = list_attraction.IndexOf(req_attractid);
                if (index >= req_attractnear.Length) return -1;
                string attract_distanceid = req_attractnear[index];
                if (list_cur_attracts.Contains(req_attractid)) //Current attract
                {
                    foreach (_AttractionInfo tmp in list_attractionobjects)
                    {
                        if (tmp.attrid == req_attractid && tmp.distanceid != attract_distanceid) //Modified 
                        {
                            param.Clear();
                            param.Add(new SqlParameter("@propid", propid));
                            param.Add(new SqlParameter("@attrid", req_attractid));
                            param.Add(new SqlParameter("@distanceid", attract_distanceid));
                            param.Add(new SqlParameter("@method", 2));
                            CommonProvider.getScalarValueFromDB("uspUpdatePropertyAttractionByID", param); //if return value = -1 error
                            break;
                        }
                    }
                    list_cur_attracts.Remove(req_attractid);
                }
                else //New attract
                {
                    param.Clear();
                    param.Add(new SqlParameter("@propid", propid));
                    param.Add(new SqlParameter("@attrid", req_attractid));
                    param.Add(new SqlParameter("@distanceid", attract_distanceid));
                    param.Add(new SqlParameter("@method", 0));
                    CommonProvider.getScalarValueFromDB("uspUpdatePropertyAttractionByID", param); //if return value = -1 error
                }

            }
        }
        foreach(string removed_attract in list_cur_attracts)
        {
            param.Clear();
            param.Add(new SqlParameter("@propid", propid));
            param.Add(new SqlParameter("@attrid", removed_attract));
            param.Add(new SqlParameter("@method", 1));
            CommonProvider.getScalarValueFromDB("uspUpdatePropertyAttractionByID", param); //if return value = -1 error
        }
        return 0;
    }
}

public class RoomInfoFurniture
{
    public string RoomID { get; set; }
    public string FurnitureItemID { get; set; }
}

public class _AttractionInfo
{
    public string attrid { get; set; }
    public string distanceid { get; set; }
}