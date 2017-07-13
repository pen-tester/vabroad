using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class CreateSitemap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        XmlWriterSettings settings = new XmlWriterSettings();
        settings.Indent = true;
        settings.Encoding = Encoding.UTF8;

        string xmlDoc = Server.MapPath("~/sitemap.xml");

        using (XmlWriter writer = XmlWriter.Create(xmlDoc, settings))
        {
            writer.WriteStartDocument();
            writer.WriteStartElement("urlset");
            writer.WriteAttributeString("xmlnss", "http://www.sitemaps.org/schemas/sitemap/0.9");
            addSpecialElement(writer);
            addRegionElements(writer);
            addCountryElements(writer);
            addStateElements(writer);
            addCityElements(writer);
            addPropertyElements(writer);

            writer.WriteEndElement();
            writer.WriteEndDocument();
        }
        Response.Redirect("~/sitemap.xml");
    }

    public string site_addr = "https://www.vacations-abroad.com";

    public void addSpecialElement(XmlWriter writer)
    {
        writer.WriteStartElement("url");

        writer.WriteElementString("loc", String.Format("{0}/default.aspx", site_addr));
        writer.WriteElementString("changefreq", "hourly");
        writer.WriteElementString("priority", "1.0");

        writer.WriteEndElement();
    }
    public void addRegionElements(XmlWriter writer)
    {
        DataSet reg_list = SiteMapHelper.getRegionList();
        int count = reg_list.Tables[0].Rows.Count;
        for(int i=0; i<count; i++)
        {
            writer.WriteStartElement("url");

            writer.WriteElementString("loc", String.Format("{0}/{1}/default.aspx", site_addr, reg_list.Tables[0].Rows[i][1]).ToLower().Replace(" ","_"));
            writer.WriteElementString("changefreq", "monthly");
            writer.WriteElementString("priority", "1.0");

            writer.WriteEndElement();
        }
    }
    public void addCountryElements(XmlWriter writer)
    {
        DataSet reg_list = SiteMapHelper.getCountryList();
        int count = reg_list.Tables[0].Rows.Count;
        for (int i = 0; i < count; i++)
        {
            writer.WriteStartElement("url");

            writer.WriteElementString("loc", String.Format("{0}/{1}/default.aspx", site_addr, reg_list.Tables[0].Rows[i][1]).ToLower().Replace(" ", "_"));
            writer.WriteElementString("changefreq", "monthly");
            writer.WriteElementString("priority", "1.0");

            writer.WriteEndElement();
        }
    }

    public void addStateElements(XmlWriter writer)
    {
        DataSet reg_list = SiteMapHelper.getStateList();
        int count = reg_list.Tables[0].Rows.Count;
        for (int i = 0; i < count; i++)
        {
            writer.WriteStartElement("url");

            writer.WriteElementString("loc", String.Format("{0}/{1}/{2}/default.aspx", site_addr, reg_list.Tables[0].Rows[i][0], reg_list.Tables[0].Rows[i][1]).ToLower().Replace(" ","_"));
            writer.WriteElementString("changefreq", "monthly");
            writer.WriteElementString("priority", "0.9");

            writer.WriteEndElement();
        }
    }
    public void addCityElements(XmlWriter writer)
    {
        DataSet reg_list = SiteMapHelper.getCityList();
        int count = reg_list.Tables[0].Rows.Count;
        for (int i = 0; i < count; i++)
        {
            writer.WriteStartElement("url");

            writer.WriteElementString("loc", String.Format("{0}/{1}/{2}/{3}/default.aspx", site_addr, reg_list.Tables[0].Rows[i][0], reg_list.Tables[0].Rows[i][1], reg_list.Tables[0].Rows[i][2]).ToLower().Replace(" ","_"));
            writer.WriteElementString("changefreq", "weekly");
            writer.WriteElementString("priority", "0.8");

            writer.WriteEndElement();
        }
    }
    public void addPropertyElements(XmlWriter writer)
    {
        DataSet reg_list = SiteMapHelper.getPropertyList();
        int count = reg_list.Tables[0].Rows.Count;
        for (int i = 0; i < count; i++)
        {
            writer.WriteStartElement("url");

            writer.WriteElementString("loc", String.Format("{0}/{1}/{2}/{3}/{4}/default.aspx", site_addr, reg_list.Tables[0].Rows[i][0], reg_list.Tables[0].Rows[i][1], reg_list.Tables[0].Rows[i][2], reg_list.Tables[0].Rows[i][3]).ToLower().Replace(" ","_"));
            writer.WriteElementString("changefreq", "monthly");
            writer.WriteElementString("priority", "0.7");

            writer.WriteEndElement();
        }
    }
}