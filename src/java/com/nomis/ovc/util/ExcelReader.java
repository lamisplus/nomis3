/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nomis.ovc.util;

import com.nomis.ovc.dao.DaoUtility;
import com.nomis.ovc.metadata.OrganizationUnit;
import com.nomis.ovc.util.AppUtility;
import com.nomis.ovc.util.DateManager;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

/**
 *
 * @author Siaka
 */
public class ExcelReader implements Serializable
{
   private String inputFile;

  public void setInputFile(String inputFile)
  {
    this.inputFile = inputFile;
  }
  public List uploadOrganizationUnitsFromExcel(InputStream inputStream) throws IOException  
  {
      List dataList=new ArrayList();
    Workbook w;
    //int numberSaved=0;
    
    try 
    {
        //AppUtility appUtil=new AppUtility();
      w = Workbook.getWorkbook(inputStream); 
      int count=w.getNumberOfSheets();
      DaoUtility util=new DaoUtility();
      OrganizationUnit ou=null;
      for(int a=0; a<count; a++)
      {
      Sheet sheet = w.getSheet(a);
            
      System.err.println("Sheet name is "+sheet.getName());
      for (int j = 1; j < sheet.getRows(); j++)
      {
        ou=new OrganizationUnit();
        for (int i = 0; i < sheet.getColumns(); i++)
        {
          Cell cell = sheet.getCell(i, j);
          if(i==0)
          {
              if(!isEmpty(cell.getContents()))
              {
                ou.setParentId(cell.getContents().trim());
              }
          }
          if(i==1)
          {
              if(!isEmpty(cell.getContents()))
              {
                ou.setOucode(cell.getContents().trim());
              }
          }
          else if(i==2)
          {
              if(!isEmpty(cell.getContents()))
              {
                ou.setName(cell.getContents().trim());
              }  
          }
          else if(i==3)
          {
             if(!isEmpty(cell.getContents()))
              {
                ou.setOulevel(Integer.parseInt(cell.getContents().trim()));
              }
          }          
        }
        System.err.println("Parent is "+ou.getParentId()+" code is "+ou.getOucode()+" name is "+ou.getName()+" Level is "+ou.getOulevel());
        dataList.add(ou);  
      }
      }
    }     
    catch (BiffException be) 
    {
      be.printStackTrace();
    }
    catch (Exception ex) 
    {
      ex.printStackTrace();
    }
    return dataList;
  } 
  private String cleanServiceString(String serviceString)
  {
      //System.err.println("serviceString is "+serviceString);
      if(serviceString !=null)
      {
        serviceString=serviceString.trim();
          
        if((serviceString.trim().indexOf("false,") !=-1 || serviceString.trim().indexOf(",false") !=-1) || (serviceString.trim().indexOf("true,") !=-1 || serviceString.trim().indexOf(",true") !=-1))
        {
            serviceString=serviceString.replace("false", "");
            serviceString=serviceString.replace("true", "");
            serviceString=serviceString.replace(",,", ",");
        }
        if(serviceString.startsWith(","))
        {
            serviceString=serviceString.substring(1);
        }
        if(serviceString.endsWith(","))
        serviceString=serviceString.substring(0,serviceString.lastIndexOf(",")-1); 
        if(serviceString.trim().equalsIgnoreCase(",") || serviceString.trim().equalsIgnoreCase("TRUE") || serviceString.trim().equalsIgnoreCase("FALSE") || serviceString.trim().length()==0)
        serviceString=null;
      }
      //System.err.println("Cleaned serviceString is "+serviceString);
        return serviceString;
  }
  
  private int getBooleanValueAsInt(String strBoolean)
  {
      int value=0;
      if(!isEmpty(strBoolean))
      {
          if(strBoolean.equalsIgnoreCase("TRUE"))
          value=1;
          else if(strBoolean.equalsIgnoreCase("FALSE"))
          value=0;
          else
          value=Integer.parseInt(strBoolean);
      }
      return value;
  }
  public boolean isEmpty(String value)
  {
      if(value !=null && !value.equalsIgnoreCase("") && !value.equalsIgnoreCase(" ") && !value.equalsIgnoreCase("  "))
      return false;
      return true;
  }
  private String getDateFromDayMthYear(String dayMthAndYear)
  {
      String[] dateArray=null;
      String date=null;
      //System.err.println("dayMthAndYear is "+dayMthAndYear);
      if(dayMthAndYear !=null)
      {
          AppUtility appUtil=new AppUtility();
           if(dayMthAndYear.indexOf("-") !=-1 && dayMthAndYear.indexOf("--") ==-1)
           {
               String strYr=" ";
                 dateArray=dayMthAndYear.split("-");
                 int day=Integer.parseInt(dateArray[0]);
                 int mth=appUtil.getMonthAsNumber(dateArray[1]);
                 int year=Integer.parseInt(dateArray[2]);
                 if(dateArray[0].length()==4)
                 date=dayMthAndYear;
                 else
                 {
                     if(dateArray[2].trim().length()==2)
                     {
                         strYr="19"+dateArray[2];
                         if(year<19)
                         strYr="20"+dateArray[2];
                     }
                     else
                     strYr=dateArray[2];
                     if(strYr.trim().length()==4)
                     date=strYr+"-"+mth+"-"+day;
                 }
                 
           }
           else if(dayMthAndYear.indexOf("/") !=-1)
           {
               String strYr=" ";
                dateArray=dayMthAndYear.split("/");
                int day=Integer.parseInt(dateArray[0]);
                 int mth=Integer.parseInt(dateArray[1]);//appUtil.getMonthAsNumber(dateArray[1]);
                 int year=Integer.parseInt(dateArray[2]);
                 if(dateArray[0].trim().length()==4)
                 {
                    date=dayMthAndYear;
                    date=date.replaceAll("/", "-");
                 }
                 else
                 {
                     if(dateArray[2].trim().length()==2)
                     {
                         strYr="19"+year;
                         if(year<19)
                         strYr="20"+year;
                     }
                     else
                     strYr=dateArray[2];
                     if(strYr.trim().length()==4)
                     date=strYr+"-"+mth+"-"+day;
                 }
           }
           else
           {
              date=null;
               System.err.println("Wrong date format "+dayMthAndYear);
           }
      }
      System.err.println("Date is "+date);
      return date;
  }
  private String getDate(String mthAndYear)
  {
      String[] dateArray=null;
      String date=null;
      if(mthAndYear !=null)
      {
          AppUtility appUtil=new AppUtility();
           if(mthAndYear.indexOf("-") !=-1)
           {
                 dateArray=mthAndYear.split("-");
                 int mth=appUtil.getMonthAsNumber(dateArray[0]);
                 date="20"+dateArray[1]+"-"+mth+"-01";
           }
           else if(mthAndYear.indexOf("/") !=-1)
           {
                dateArray=mthAndYear.split("/");
                int mth=appUtil.getMonthAsNumber(dateArray[0]);
                date="20"+dateArray[1]+"-"+mth+"-01";
           }
           else
           {
              date=null;
               System.err.println("Wrong date format "+mthAndYear);
           }
      }
      return date;
  }
  private String getDateFromMthDayYear(String cellContent)
  {
      String date=null;
      if(cellContent !=null && !isEmpty(cellContent))
      {
        String[] dateArray=null;
        if(cellContent.indexOf("-") !=-1 )
        {
            dateArray=cellContent.split("-");
            if(dateArray[0].length()==4)
            date=cellContent.trim();
            else
            {
                DateManager dm=new DateManager();
                dateArray=cellContent.split("/");
                String mth=dm.getMonthAsNumber(dateArray[0]);
                date="20"+dateArray[1]+"-"+mth+"-01";
            }
        }
        else if(cellContent.indexOf("/") !=-1)
        {
            DateManager dm=new DateManager();
            dateArray=cellContent.split("/");
            String mth=dm.getMonthAsNumber(dateArray[0]);
            date="20"+dateArray[1]+"-"+mth+"-01";
        }
      }
      return date;
  }
}