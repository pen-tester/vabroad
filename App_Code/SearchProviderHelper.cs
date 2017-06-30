using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SearchProviderHelper
/// </summary>
/// 
public class PropertyTypeSearchInfo
{
    public int ID { get; set; }
    public string Name { get; set; }
    public int Nums { get; set; }
}

public class BedroomsSearchInfo
{
    public int ID { get; set; }
    public string Name { get; set; }
    public int Nums { get; set; }
}

public class AmenitySearchInfo
{
    public int ID { get; set; }
    public string Name { get; set; }
    public int Nums { get; set; }
}

public class AmenityInfo
{
    public int ID { get; set; }
    public int AmenityID { get; set; }
    public string Amenity { get; set; }
}


public class PropertyDetailInfo
{
    //.ID,.Name,.Address,.NumBedrooms,.NumBaths, .NumSleeps, .NumTVs,.NumVCRs, .NumCDPlayers,.Name2, .MinNightRate,.HiNightRate,.City,.StateProvince,.Country,.PropertyName
    public int ID { get; set; }
    public int UserID { get; set; }
    public string Name { get; set; }
    public string Address { get; set; }
    public int TypeID { get; set; }
    public int NumBedrooms { get; set; }
    public int NumBaths { get; set; }
    public int NumSleeps { get; set; }
    public int NumTVs { get; set; }
    public int NumVCRs { get; set; }
    public int NumCDPlayers { get; set; }
    public string Name2 { get; set; }
    public int MinNightRate { get; set; }
    public int HiNightRate { get; set; }
    public string Description { get; set; }
    public string Amenities { get; set; }
    public string LocalAttractions { get; set; }
    public int MinimumNightlyRentalID { get; set; }
    public string MinRateCurrency { get; set; }
    public string Rates { get; set; }
    public string CancellationPolicy { get; set; }
    public string DepositRequired { get; set; }
    public int CityID { get; set; }
    public string City { get; set; }
    public int StateProvinceID { get; set; }
    public int IfShowAddress { get; set; }
    public string StateProvince { get; set; }
    public int CountryID { get; set; }
    public string Country { get; set; }
    public string VirtualTour { get; set; }
    public int RegionID { get; set; }
    public string PropertyName { get; set; }
    public string CategoryTypes { get; set; }
    public int CategoryID { get; set; }
    public string FileName { get; set; }
    public float loc_latlang { get; set; }
    public float loc_logitude { get; set; }
    public int loc_verified { get; set; }
}

public class PropertyAmenityInfo
{
   public  PropertyDetailInfo detail;
    public List<AmenityInfo> amenity = new List<AmenityInfo>();

}

public class AjaxPropListSet
{
    public int allnums = 0;
    public List<PropertyAmenityInfo> propertyList;
}

public class CountryInfoWithCityID
{
    public string Region { get; set; }
    public string StateProvince { get; set; }
    public string Country { get; set; }
    public string City { get; set; }
    public string CityText { get; set; }
    public string CityText2 { get; set; }
    public string descriptionoverride { get; set; }
    public string titleoverride { get; set; }


    //Regions.Region, co.Country, co.City, co.CityText, co.descriptionoverride, co.titleoverride
}

public class CountryInfoWithStateID
{
    public string Region { get; set; }
    public string StateProvince { get; set; }
    public string Country { get; set; }
    public string City { get; set; }
    public string CityText { get; set; }
    public string CityText2 { get; set; }
    public string descriptionoverride { get; set; }
    public string titleoverride { get; set; }


    //Regions.Region, co.Country, co.City, co.CityText, co.descriptionoverride, co.titleoverride
}

public class CouponItem
{
    public int CID { get; set; }
    public string Coupon { get; set; }
    public string Start_date { get; set; }
    public string End_date { get; set; }
    public int Discount{ get; set; }

}

public class SearchProviderHelper
{
    public SearchProviderHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}