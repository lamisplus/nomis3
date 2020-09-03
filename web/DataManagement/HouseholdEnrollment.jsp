<%-- 
    Document   : HouseholdEnrollment
    Created on : Dec 2, 2019, 9:39:53 PM
    Author     : smomoh
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Household Vulnerability assessment form</title>
<link href="images/untitled.css" rel="stylesheet" type="text/css" />
<link href="images/sdmenu/sdmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
        font-size: 12px;
	background-image: url(images/bg.jpg);
	background-repeat: repeat-x;
}
-->
</style>
<script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<link href="images/untitled.css" rel="stylesheet" type="text/css" />
<link href="images/sdmenu/sdmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
a {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
a:active {
	text-decoration: none;
}
.whiteLabel
{
    color: white;
    font-size: 14;
}
-->
</style>
<!--<link href="sdmenu/sdmenu.css" rel="stylesheet" type="text/css" />-->
<link type="text/css" href="css/ui-darkness/jquery-ui-1.8.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="js/odm.js"></script>
<script language="javascript">
/*var req;
 var which;
 var callerId=""
 var resetId=0
 var searchIndex=0
 var eligibility=" "
 var daysOfBirthId=""
function getValuesByAjaxApi(url,str,id)
{
    callerId=id;
    xmlhttp=GetXmlHttpObject();
    if (xmlhttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    url=url+"?qparam="+str;
    url=url+"&id="+id;
    url=url+"&sid="+Math.random();
    //alert(url+"---"+str)
    xmlhttp.onreadystatechange=stateChanged;
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
}
function GetXmlHttpObject()
{
    if (window.XMLHttpRequest)
    {
        return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
    return null;
}*/
$(function() {
        $("#dateOfAssessment").datepicker();
        $("#dateOfBaselineHivStatus").datepicker();
        $("#dateEnrolledOnTreatment").datepicker();
    });
function stateChanged()
{
	if (xmlhttp.readyState==4)
	{
            var val=xmlhttp.responseText;
            if(callerId=="search")
            {
                showSearchResult(val)
            }
            else if(callerId=="schoolList")
            {
                loadSchoolList(val)
            }
           else
           {//alert(value)
              if(val.indexOf("-") !=-1)
              {
                document.getElementById("hhUniqueId").value=val
                //document.getElementById("errIdMsg").innerHTML=" Incomplete Id"
              }
              else
              {
                document.getElementById("hhUniqueId").value=val
              }
           }
	}
        else
        {
            //alert("error "+xmlhttp.responseText)
        }
}
function activateEnrolledOnTreatment(value)
{
    //if beneficiary is hiv positive
    if(value == "1") 
    {
        document.getElementById("enrolledOnTreatment").disabled = false;
        
        document.getElementById("dateOfBaselineHivStatus").disabled = false;
        if(document.getElementById("enrolledOnTreatment").value==1)
        {
            document.getElementById("dateEnrolledOnTreatment").disabled = false;
            document.getElementById("treatmentId").disabled = false;
        }
        else
        {
            document.getElementById("dateEnrolledOnTreatment").value = "";
            document.getElementById("dateEnrolledOnTreatment").disabled = true;
            document.getElementById("treatmentId").value = "";
            document.getElementById("treatmentId").disabled = true;
        }
    }
    else 
    {
       document.getElementById("enrolledOnTreatment").value=2
       document.getElementById("enrolledOnTreatment").disabled = true;
       document.getElementById("hivTreatmentFacilityId").value="select"
       document.getElementById("hivTreatmentFacilityId").disabled = true;
       document.getElementById("dateEnrolledOnTreatment").value = "";
       document.getElementById("dateOfBaselineHivStatus").value = "";
       document.getElementById("dateEnrolledOnTreatment").disabled = true;
       document.getElementById("treatmentId").value = "";
       document.getElementById("treatmentId").disabled = true;
       document.getElementById("dateOfBaselineHivStatus").disabled = false;
       if(value == "0" || value == "3" || value == "4") 
       {
           document.getElementById("dateOfBaselineHivStatus").disabled = true;
       }
    }
}
function activateReferralList(value) 
{
    if(value == "1") 
    {
        document.getElementById("hivTreatmentFacilityId").disabled = false;
        document.getElementById("treatmentId").disabled = false;
        document.getElementById("dateEnrolledOnTreatment").disabled = false;
    }
    else 
    {
        document.getElementById("hivTreatmentFacilityId").value="select"
        document.getElementById("hivTreatmentFacilityId").disabled = true;
        document.getElementById("dateEnrolledOnTreatment").disabled = true;
        document.getElementById("treatmentId").value = "";
        document.getElementById("treatmentId").disabled = true;
    }
}
function generateUniqueId()
{
    level2OuId=document.getElementById("level2OuId").value;
    level3OuId=document.getElementById("level3OuId").value;
    cboUniqueId=document.getElementById("cboId").value;
    serialNumber=document.getElementById("serialNo").value;
    req=level2OuId+";"+level3OuId+";"+cboUniqueId+";"+serialNumber
    getValuesByAjaxApi('ajaxaction.do',req,'uniqueId')
    return true;
}
function submitForm(requiredAction,formId)
{
       setActionName(requiredAction)
       document.getElementById(formId).submit()
       return true
}

function confirmAction(name)
{
     if(name=="save" || name=="generateForms")
     {
            setActionName(name)
            return true
     }
     if(confirm("Are you sure you want to "+name+" this record?"))
     {
            setActionName(name)
            return true
     }
       return false
}
function setActionName(val)
{
    document.getElementById("actionName").value=val
}
</script>
<link href="kidmap-default.css" rel="stylesheet" type="text/css" />
<link href="images/kidmap2.css" rel="stylesheet" type="text/css" />
<link href="images/untitled.css" rel="stylesheet" type="text/css" />
<link href="images/sdmenu/sdmenu.css" rel="stylesheet" type="text/css" />
</head>

<body onload="MM_preloadImages('images/About_down.jpg','images/Admin_down.jpg','images/Rapid_down.jpg','images/care_down.jpg','images/OVC_down.jpg');">

<table width="949" border="0" align="center" cellpadding="0" cellspacing="0" class="boarder">
  <!--DWLayoutTable-->
  <tr>
    <td height="117" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <!--DWLayoutTable-->
      <tr>
        <td width="7" height="2"></td>
          <td width="271"></td>
          <td width="137"></td>
          <td width="95"></td>
          <td width="8"></td>
          <td width="95"></td>
          <td width="8"></td>
          <td width="95"></td>
          <td width="8"></td>
          <td width="95"></td>
          <td width="8"></td>
          <td width="95"></td>
          <td width="23"></td>
        </tr>

<jsp:include page="../includes/Pagetabs.jsp" />

      <tr>
        <td height="30"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>&nbsp;</td>
        <td></td>
        <td></td>
        <td></td>
        </tr>

      <tr>
        <td height="17"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><jsp:include page="../Navigation/Logout.jsp" /></td>
          <td></td>
        </tr>
      <tr>
        <td height="3" colspan="13" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#038233">
          <!--DWLayoutTable-->
          <tr>
            <td width="945" height="2"></td>
            </tr>
          <!--DWLayoutTable-->
          <tr>
            <td height="1"></td>
              </tr>
        </table></td>
        </tr>

    </table></td>
  </tr>
  <tr>
    <td width="931" height="251" valign="top">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <!--DWLayoutTable-->
      <tr>
        
        <td width="231" rowspan="2" valign="top"  bgcolor="#038233">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#038233">
          <!--DWLayoutTable-->
          <tr>
            <td width="231" height="28" valign="top">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="231" height="28"><img src="images/dataentry.jpg" width="231" height="28" /></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td height="85" valign="top">
                <div style="float: left" id="my_menu" class="sdmenu">
                    <div>
                        <div><jsp:include page="../Navigation/DataEntryLinkPage.jsp"/></div>
                        
                    </div>
              </div>

            </td>
          </tr>
          <tr>
            <td height="30" valign="top">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="180" height="30"><img src="images/reports.jpg" width="231" height="30" /></td>
                    </tr>
            </table></td>
          </tr>
          <tr>
            <td height="157" valign="top"><div style="float: left" id="my_menu2" class="sdmenu" >
              <div><jsp:include page="../Navigation/ReportLinkPage.jsp"/></div>
            </div></td>
          </tr>
      </table></td>
    <td width="10">&nbsp;</td>
      <td width="659" class="regsitertable">
        <html:form action="/householdenrollment" method="POST" styleId="hheform">
                                <html:hidden property="actionName" styleId="actionName" />
                                <html:hidden property="existingHhUniqueId" styleId="existingHhUniqueId" />
                            <center>
                                <table>
                                    <tr><td colspan="4" align="center"><logic:present name="accessErrorMsg">${accessErrorMsg}</logic:present></td></tr>
                                    <tr><td colspan="4" align="center" >Household Vulnerability assessment form</td></tr>
                                    <jsp:include page="../includes/OrganizationUnitHeader.jsp"/>
                                    
                                    <tr><td colspan="4" align="center" style="color:red"><html:errors/></td></tr>
                                    
                                    <tr>
                                        <td colspan="4">
                                          <fieldset><legend >Household information</legend>  
                                            
                                        <table>
                                           <%-- <tr>
                                                    <td > </td>
                                                    <td colspan="3">
                                                        &nbsp;<input type="button" name="search" value="Search by name" onclick="showSearchDiv()" /> 
                                                        
                                                    </td>              
                                            </tr>--%> 
                                    <tr>
                            
                                        <td  align="right">Serial No. </td>
                                        <td>
                                            <html:text property="serialNo"  styleId="serialNo" onkeyup="return generateUniqueId()" onblur="return submitForm('hhvaDetails','hheform')"/>
                                        </td>
                                        <td  align="right"> </td>
                            <td > 
                                <input type="button" name="search" value="Search by name" onclick="showSearchDiv()" />     
                            </td>
                          </tr>   
                                    <tr>
                            
                                        <td  align="right">HH Unique Id </td>
                                        <td>
                                            <html:text property="hhUniqueId" styleId="hhUniqueId" style="width:150px;" onblur="setActionName('loadHousehold');forms[0].submit()" readonly="true" />
                                        </td>
                                        <td  align="right">Date of assessment </td>
                            <td > 
                                <html:text property="dateOfAssessment" styleId="dateOfAssessment"  style="width:150px;" />
                                      
                            </td>
                          </tr>
                          <tr>
                                        <td align="right" > Caregiver first name</td>
                                        <td>
                                            <html:text property="firstName" styleId="firstName" style="width:150px;"/> 
                                            </td>
                                           <td align="right" >Last name </td>
                                        <td > 
                                            <html:text property="surname" styleId="surname" style="width:150px;"/>
                                                
                                        </td>
                                        
                                     </tr>
                                     <tr>
                                        <td align="right" >Sex</td>
                                        <td>
                                            <html:select property="cgSex" styleId="cgSex" style="width:155px;"> 
                                            <html:option value="M">Male</html:option>
                                                <html:option value="F">Female</html:option>
                                            </html:select>
                                            </td>
                                           <td align="right" >Age </td>
                                        <td > 
                                            <html:text property="cgAge" styleId="cgAge" style="width:150px;"/>
                                                
                                        </td>
                                        
                                     </tr>
                                     <tr>
                                        <td align="right">Marital status</td>
                                        <td colspan="3">
                                            <html:select property="maritalStatus" styleId="maritalStatus" style="width:155px;">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Single/Never married</html:option>
                                                <html:option value="2">Separated</html:option>
                                                <html:option value="3">Married</html:option>
                                                <html:option value="4">Widowed</html:option>
                                                <html:option value="5">Divorced</html:option>
                                                
                                            </html:select>
                                        </td>
                                     </tr>
                                     <tr>
                                         <td align="right" >Address</td>
                                         <td colspan="3" > 
                                            <html:textarea property="address" styleId="address" style="width:500px;"/> 
                                        </td>
                                        
                                        
                                     </tr>
                                     <tr> 
                             <td>HIV status</td>
                            <td>
                                <html:select property="baselineHivStatus" styleId="baselineHivStatus" onchange="activateEnrolledOnTreatment(this.value)" style="width: 147px;">
                                    <logic:present name="mainHivStatus">
                                        <logic:iterate name="mainHivStatus" id="hivStatus">
                                            <html:option value="${hivStatus.code}">${hivStatus.name}</html:option>
                                        </logic:iterate>
                                    </logic:present>
                                    
                                </html:select>
                            </td>
                            <td align="right">Date of HIV status </td>
                            <td>
                                <html:text property="dateOfBaselineHivStatus" styleId="dateOfBaselineHivStatus" style="width:100px;" />
                                  
                            </td>

                         </tr>
                         <tr> 
                     <td width="300">Enrolled on treatment? </td>
                            <td>
                                <html:select property="enrolledOnTreatment" styleId="enrolledOnTreatment" style="width:148px;" onchange="activateReferralList(this.value)" disabled="${hhHivDisabled}">
                                  <html:option value="0">N/A</html:option>
                                    <html:option value="2">No</html:option>
                                  <html:option value="1">Yes</html:option>
                                </html:select>
                            </td>
                             <td align="right">Date enrolled</td>
                            <td>
                                <html:text property="dateEnrolledOnTreatment" styleId="dateEnrolledOnTreatment" disabled="${hhHivDisabled}"/>
                                    
                            </td>
                            

                         </tr>
                         <tr>
                <td >Facility enrolled</td>
                <td colspan="3" > 
                    <html:select property="hivTreatmentFacilityId" styleId="hivTreatmentFacilityId"  style="width:500px;" disabled="${hhHivDisabled}">
                          <html:option value="select">select...</html:option>
                          <html:option value="xxxxxxxxxxx">Default facility</html:option>
                          <logic:present name="ovcfacilityList">
                              <logic:iterate name="ovcfacilityList" id="facility">
                                  <html:option value="${facility.facilityId}">${facility.facilityName}</html:option>
                            </logic:iterate>
                          </logic:present>
                      </html:select>
                </td>
              </tr>
              <tr>
                <td >Treatment/ART No.</td>
                <td colspan="3" > 
                    <html:text property="treatmentId" styleId="treatmentId"  style="width:150px;" disabled="${hhHivDisabled}"/>
                          
                </td>
              </tr>
                                        </table>
                                          </fieldset>    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <fieldset><legend >HEALTHY</legend>
                                            <table border="1" bordercolor="black" class="regsitertable" style="color: black">
                                      <tr>
                                          <td colspan="3"><label> All children, adolescents, and caregiver(s) in the household have known HIV status or a test is not required based on risk assessment.</label> </td>
                                        <td >
                                            <html:select property="hivStatusKnown" styleId="hivStatusKnown" onblur="generateUniqueId()">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label> All HIV+ children, adolescents and caregiver in the household are linked to and have adhered to treatment for 12 months after initiation of ART</label> </td>
                                        <td >
                                            <html:select property="hivPositiveLinked" styleId="hivPositiveLinked" onblur="generateUniqueId()">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label> All HIV+ children, adolescents and caregiver(s) in the household have a viral load result documented in the last 12 months</label> </td>
                                        <td >
                                            <html:select property="hasViralLoadResult" styleId="hasViralLoadResult" onblur="generateUniqueId()">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label> All adolescents 10-17 years of age in the household have key knowledge about preventing HIV infection</label> </td>
                                        <td >
                                            <html:select property="hivPreventionKnowledge" styleId="hivPreventionKnowledge" onblur="generateUniqueId()">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label>No children < 5 years in the household are undernourished </label> </td>
                                        <td >
                                            <html:select property="childUndernourished" styleId="childUndernourished">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                          
                                    </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    
                                    
                                    <tr>
                                        <td colspan="4">
                                            <fieldset><legend >SAFE</legend>
                                            <table border="1" bordercolor="black" class="regsitertable" style="color: black ">
                                      <tr>
                                          <td colspan="3"><label> All children in the household have birth certificates</label> </td>
                                        <td >
                                            <html:select property="childrenHasBirthCertificate" styleId="childrenHasBirthCertificate">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label>There is a stable adult in the household who provides consistent care, attention and support to the children and adolescents?</label> </td>
                                        <td >
                                            <html:select property="stableAdult" styleId="stableAdult">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label> Children, adolescent or caregivers in the household reported experience(s) of violence in the last 6 months</label> </td>
                                        <td >
                                            <html:select property="violenceExperienceReported" styleId="violenceExperienceReported" onblur="generateUniqueId()">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                    
                                    </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <fieldset><legend >SCHOOLED</legend>
                                            <table border="1" bordercolor="black" class="regsitertable" style="color: black ">
                                      <tr>
                                          <td colspan="3" style="width:650px;"><label>All children aged 6 years and above are enrolled in school</label> </td>
                                        <td >
                                            <html:select property="childrenEnrolledInSchool" styleId="childrenEnrolledInSchool">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                         <td colspan="3"><label>All children and adolescent enrolled in school have attended regularly and progressed in the last year </label> </td>
                                        <td >
                                            <html:select property="regularSchoolAttendance" styleId="regularSchoolAttendance" >
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                    
                                    </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td colspan="4">
                                            <fieldset><legend >STABLE</legend>
                                            <table border="1" bordercolor="black" class="regsitertable" style="color: black">
                                      <tr>
                                          <td colspan="3" style="width:650px;"><label>Caregiver is engaged in economic activities that helps meet the critical needs of the children in the household.</label> </td>
                                        <td >
                                            <html:select property="cgEngagedInEconomicActivities" styleId="cgEngagedInEconomicActivities" onblur="generateUniqueId()">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                     <tr>
                                          <td colspan="3"><label>Caregiver can identify an individual or group recognized as providing social and emotional support</label> </td>
                                        <td >
                                            <html:select property="socialEmotionalSupport" styleId="socialEmotionalSupport" >
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">Yes</html:option>
                                                <html:option value="2">No</html:option>
                                            </html:select>
                                           </td>
                                            
                                     </tr>
                                    
                                            </fieldset>
                                        </td>
                                    </tr>
                                    
                                    </table>
                                    <tr>
                                          <td ><label >Name of volunteer</label> </td>
                                        <td colspan="3">
                                            <html:select property="volunteerName" styleId="volunteerName" style="width:300px;" >
                                                <html:option value="select">select...</html:option>
                                                <logic:present name="communityWorkerList">
                                                    <logic:iterate name="communityWorkerList" id="communityWorker">
                                                        <html:option value="${communityWorker.communityWorkerId}">${communityWorker.firstName} ${communityWorker.surname}</html:option>
                                                    </logic:iterate>
                                                </logic:present>
                                                
                                            </html:select>
                                           </td>
                                           <td>&nbsp; </td><td>&nbsp;</td>  
                                     </tr>
                                    <tr><td colspan="4" align="center"><html:submit value="Save" onclick="setActionName('save')" disabled="${hheSaveDisabled}"/>
                                            <html:submit value="Modify" onclick="return confirmAction('modify')" disabled="${hheModifyDisabled}"/>
                                        <html:submit value="Delete" onclick="return confirmAction('delete')" disabled="${hheModifyDisabled}"/>
                                        </td></tr>
                                    
                                    
                                </table>
                            </center>
                            </html:form>
         </td>
      
    <td width="18">&nbsp;</td>
  </tr>

  <tr>
    <td height="25" colspan="2" valign="top">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#038233">
      <!--DWLayoutTable-->
      <tr>
        <td width="945" height="25" class="copyright"><jsp:include page="../includes/Version.jsp"/></td>
        </tr>
    </table></td>
  </tr>
</table>
  </body>
</html>
