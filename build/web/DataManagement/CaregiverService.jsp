<%-- 
    Document   : CaregiverService
    Created on : Dec 16, 2019, 8:37:36 PM
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
<title>Caregiver service form</title>
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
<link href="sdmenu/sdmenu.css" rel="stylesheet" type="text/css" /> 
<link href="css/general/stylefile.css" rel="stylesheet" type="text/css"/>
<link type="text/css" href="css/ui-darkness/jquery-ui-1.8.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js"></script>
        
<script type="text/javascript" src="js/odm.js"></script>
<script language="javascript">
var beneficiaryType=0
$(function() {
        $("#serviceDate").datepicker();
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
           {
               //alert(beneficiaryType)
              
                if(beneficiaryType==1)
                {
                    document.getElementById("hhId").innerHTML=val
                    document.getElementById("hhUniqueId").value=val
                }
                
                else if(beneficiaryType==2)
                document.getElementById("ovcId").value=val
              
              <%--else
              {
                document.getElementById("hhUniqueId").value=val
              }--%>
           }
	}
        else
        {
            //alert("error "+xmlhttp.responseText)
        }
}

function generateUniqueId(val)
{
    level2OuId=document.getElementById("level2OuId").value;
    level3OuId=document.getElementById("level3OuId").value;
    cboUniqueId=document.getElementById("cboId").value;
    var req=""
    if(val==1)
    {
        serialNumber=document.getElementById("hhSerialNo").value;
        req=level2OuId+";"+level3OuId+";"+cboUniqueId+";"+serialNumber
        beneficiaryType=1
    }
    else if(val==2)
    {
        serialNumber=document.getElementById("childSerialNo").value;
        hhUniqueId=document.getElementById("hhUniqueId").value;
        req=hhUniqueId+";"+serialNumber
        beneficiaryType=2
    }
    
    //req=level2OuId+";"+level3OuId+";"+cboUniqueId+";"+serialNumber
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
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="regsitertable">
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
    <td width="10" >&nbsp;</td>
      <td width="659" class="regsitertable">
        <html:form action="/caregiverservice" method="POST" styleId="serviceForm">
                                <html:hidden property="actionName" styleId="actionName" />
                                <%--<html:hidden property="beneficiaryId" styleId="beneficiaryId" />--%>
                                <html:hidden property="hhName" styleId="hhName" />
                            <center>
                                <table>
                                    <tr><td colspan="4" align="center"><logic:present name="accessErrorMsg">${accessErrorMsg}</logic:present></td></tr>
                                    <tr><td colspan="4" align="center">Caregiver service form </td></tr>
                                      <jsp:include page="../includes/OrganizationUnitHeader.jsp" />                                  
                                      <tr><td colspan="4" align="center" style="color:red"><html:errors/></td></tr>
                                      <tr><td style="font-size: 14px; font-weight: bold; color: red" colspan="4"><logic:present name="hhsWithdrawnMessage">${hhsWithdrawnMessage}</logic:present></td></tr>
                                    <tr>
                                        <td colspan="4">
                                            
                                            <fieldset><legend>Caregiver information</legend>
                                        <table>
                                            
                                            <tr>
                                                    <td align="center" >HH Serial No </td>
                                                    
                                                    <td colspan="3">
                                                        <html:text property="hhSerialNo" styleId="hhSerialNo" onkeyup="return generateUniqueId(1);" onblur="setActionName('householdDetails');forms[0].submit()" style="width:30px;"/> 
                                                        <html:text property="hhUniqueId" styleId="hhUniqueId" /> 
                                                        &nbsp;<input type="button" name="search" value="Search by name" onclick="showSearchDiv()" /> 
                                                        &nbsp;<label id="hhId" style="color:green"><logic:present name="hhName">${hhName}</logic:present> </label> 
                                                    </td>             
                                            </tr><!--ahmList-->
                                            
                                             <tr>
                                        <td >Caregiver list </td>
                                        <td >
                                        <html:select style="width:150px;" property="beneficiaryId" styleId="beneficiaryId" onchange="setActionName('ahmDetails');forms[0].submit()">
                                                <html:option value="select">select...</html:option>
                                                <logic:present name="ahmList">
                                                    <logic:iterate name="ahmList" id="ahm">
                                                        <html:option value="${ahm.beneficiaryId}">${ahm.firstName} ${ahm.surname} (${ahm.beneficiaryTypeObject.name}) </html:option>
                                                    </logic:iterate>
                                                </logic:present>
                                            </html:select>
                                            </td>
                                            <td align="center"> 
                                                
                                                    
                                                    </td>
                                     </tr>
                                    
                                     <tr>
                                        <td align="right">Date of enrollment </td>
                                        <td >
                                            <html:text property="dateOfEnrollment" styleId="dateOfEnrollment" onchange="generateUniqueId()" disabled="true"/>
                                            </td>
                                            <td align="right">Sex </td>
                                        <td >
                                            <html:select property="sex" styleId="sex" onchange="generateUniqueId()" disabled="true">
                                                <html:option value="select">select...</html:option>
                                                <html:option value="M">Male</html:option>
                                                <html:option value="F">Female</html:option>
                                            </html:select>
                                            </td>
                                     </tr>
                                     <tr>
                                         
                                        <td align="right">Phone number</td>
                                        <td >
                                            <html:text property="phoneNumber" styleId="phoneNumber" disabled="true"/>
                                            </td>
                                        <td align="right">HIV status</td>
                                        <td>
                                            <html:select property="hivStatus" styleId="hivStatus" onchange="setEnrolledOnTreatmentStatus(this.value)" disabled="true">
                                                <logic:present name="mainHivStatus">
                                                    <logic:iterate name="mainHivStatus" id="hivStatus">
                                                        <html:option value="${hivStatus.code}">${hivStatus.name}</html:option>
                                                    </logic:iterate>
                                                </logic:present>
                                    
                                            </html:select>
                                        </td>
                                     </tr>
                                    
                                    <%--<tr>
                                        
                                        
                                        <td align="right">Education</td>
                                        <td colspan="3">
                                            <html:select property="educationLevel" styleId="educationLevel" disabled="true">
                                                <html:option value="0">select...</html:option>
                                                <html:option value="1">No formal education</html:option>
                                                <html:option value="2">Some primary education</html:option>
                                                <html:option value="3">Completed primary education</html:option>
                                                <html:option value="4">Some secondary/high school</html:option>
                                                <html:option value="5">Completed secondary or high school</html:option>
                                                <html:option value="6">Completed tertiary education</html:option>
                                                <html:option value="7">Prefer not to answer</html:option>
                                            </html:select>
                                        </td>
                                        
                                     </tr>--%>
                                                                          
                                     </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                     
                                     <tr>
                  <td valign="top" colspan="4"><fieldset>
                        <legend class="fieldset">Services </legend>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="regsitertable">
                    <!--DWLayoutTable-->
                    <tr>
                      <td width="762" height="17">
                          <table width="686" border="1" bordercolor="#D7E5F2" class="regsitertable">

			<tr>
                          <td width="20%">Date services provided: </td>
                          <td width="80%" colspan="2">
                              <html:text property="serviceDate" styleId="serviceDate" styleClass="smallfieldcellinput" onchange="setActionName('serviceDetails'); forms[0].submit()" readonly="true"/>&nbsp;(mm/dd/yyyy)
                          </td>

                        </tr>
                        </table>
                          <table width="686" border="1" bordercolor="#D7E5F2" class="regsitertable">
                          <tr style="border: #528B8B 4px solid">
                              <td width="21%" bgcolor="#CCCCCC" class="right" >HEALTHY</td>
                              <td colspan="2" bgcolor="#CCCCCC">&nbsp;</td>
                              
                          </tr>
                          
                          <tr>
                              <td rowspan="19">&nbsp;</td>
                              <td width="4%"><html:multibox property="healthServices" value="22h" styleClass="smallfieldcellselect" styleId="1h" /></td>
                            <td>Health education </td>
                          </tr>
                          <tr>
                            <td width="4%"><html:multibox property="healthServices" value="23h" styleClass="smallfieldcellselect" styleId="23h" /></td>
                            <td>Household health insurance coverage </td>
                          </tr>
                          <tr>
                            <td width="4%"><html:multibox property="healthServices" value="24h" styleClass="smallfieldcellselect" styleId="25h" /></td>
                            <td>Water, Sanitation and Hygiene (WASH) messaging</td>
                          </tr>
			   
                          <tr>

                              <td width="4%"><html:multibox property="healthServices" value="25h" styleClass="smallfieldcellselect" styleId="25h" disabled="${ahmHivPosRelatedServices}"/></td>
                            <td>Community HIV services ? HTS</td>
                          </tr>
                         
                          <tr>
                              
                              <td width="4%"><html:multibox property="healthServices" value="26h" styleClass="smallfieldcellselect" styleId="26h" disabled="${ahmNonPosRelatedServices}"/></td>
                            <td>HIV services referral ? HTS/EID/ART/PMTCT/VL/TB/STIs</td>
                          </tr>                         
                          <tr>

                              <td width="4%"><html:multibox property="healthServices" value="4h" styleClass="smallfieldcellselect" styleId="4h" disabled="${ahmHivPosRelatedServices}"/></td>
                            <td>Age-appropriate counseling and HIV disclosure support</td>
                          </tr>
                          <tr>

                              <td width="4%"><html:multibox property="healthServices" value="2h" styleClass="smallfieldcellselect" styleId="2h" disabled="${ahmArtRelatedServices}"/></td>
                            <td>HIV adherence support </td>
                          </tr>
                          <tr>
                              
                              <td><html:multibox property="healthServices" value="27h" styleClass="smallfieldcellselect" styleId="27h" disabled="${ahmHivPosRelatedServices}"/></td>
                            <td>Structured PLHA support group </td>
                          </tr>
                          <tr >
                              <td><html:multibox property="healthServices" value="28h" styleClass="smallfieldcellselect" styleId="28h" /></td>
                            <td>Community TB symptom screening</td>
                          </tr>
                          
                          <tr>
                              
                              <td><html:multibox property="healthServices" value="31h" styleClass="smallfieldcellselect" styleId="31h"/></td>
                            <td>IYCF support group</td>
                          </tr>
                          <tr>
                              
                              <td><html:multibox property="healthServices" value="32h" styleClass="smallfieldcellselect" styleId="32h"/></td>
                            <td>Healthy food demonstration</td>
                          </tr>
                          <tr>
                              
                              <td><html:multibox property="healthServices" value="30h" styleClass="smallfieldcellselect" styleId="13h"/></td>
                            <td>Health services referral</td>
                          </tr>
                         <tr>
                              <td colspan="2">
                                  <table>
                                      <logic:present name="otherCaregiverHealthList">
                                          <logic:iterate name="otherCaregiverHealthList" id="service">
                                          <tr>
                                              <td><html:multibox property="healthServices" value="${service.serviceCode}" styleClass="smallfieldcellselect" styleId="${service.serviceCode}"/></td>
                                                <td>${service.serviceName}</td>
                                          </tr>
                                          </logic:iterate>
                                      </logic:present>
                                  </table>
                              </td>
                         </tr>
                        </table>

                        <table width="686" border="1" bordercolor="#D7E5F2" class="regsitertable">
                          <tr style="border: #528B8B 4px solid">
                            <td width="21%" bgcolor="#CCCCCC" class="right">SAFE </td>
                            <td width="4%" colspan="2" bgcolor="#CCCCCC">&nbsp;</td>
                            
                          </tr>
                          
                          <tr>
                              <td rowspan="14">&nbsp;</td>
                            <td><html:multibox property="safetyServices" value="10s" styleClass="smallfieldcellselect" styleId="2s"/></td>
                            <td>Structured PSS related to family conflict mitigation</td>
                          </tr>
                          <tr>
                          <tr>
                            
                            <td width="4%"><html:multibox property="safetyServices" value="13s" styleClass="smallfieldcellselect" styleId="13s"/></td>
                            <td width="75%">Clothing support</td>
                          </tr> 
                          <tr>
                            <td><html:multibox property="safetyServices" value="6s" styleClass="smallfieldcellselect" styleId="6s"/></td>
                            <td>Emergency shelter/care facility</td>
                          </tr>
                          <tr>
                            <td><html:multibox property="safetyServices" value="12s" styleClass="smallfieldcellselect" styleId="12s"/></td>
                            <td>Post-violence trauma counselling from a trained provider</td>
                          </tr>
                          <tr>
                            <td><html:multibox property="safetyServices" value="7s" styleClass="smallfieldcellselect" styleId="7s"/></td>
                            <td>Parenting skills</td>
                          </tr>
                          <tr>
                            <td><html:multibox property="safetyServices" value="1pt" styleClass="smallfieldcellselect" styleId="1pt"/></td>
                            <td>Legal services</td>
                          </tr>
                          <tr>
                            <td><html:multibox property="safetyServices" value="2pt" styleClass="smallfieldcellselect" styleId="2pt"/></td>
                            <td> Succession planning</td>
                          </tr>
                          <tr>
                              <td><html:multibox property="safetyServices" value="17s" styleClass="smallfieldcellselect" styleId="17s"/></td>
                            <td>Birth registration awareness</td>
                          </tr>
                          <tr>
                            <td><html:multibox property="safetyServices" value="15s" styleClass="smallfieldcellselect" styleId="15s"/></td>
                            <td>Awareness on gender issues/Gender norms</td>
                          </tr>
                          <tr>
                            <td><html:multibox property="safetyServices" value="18s" styleClass="smallfieldcellselect" styleId="18s"/></td>
                            <td>Referral for safety services</td>
                          </tr>
                          <tr>
                              <td colspan="2">
                                  <table>
                                      <logic:present name="otherCaregiverSafetyList">
                                          <logic:iterate name="otherCaregiverSafetyList" id="service">
                                          <tr>
                                              <td><html:multibox property="safetyServices" value="${service.serviceCode}" styleClass="smallfieldcellselect" styleId="${service.serviceCode}"/></td>
                                                <td>${service.serviceName}</td>
                                          </tr>
                                          </logic:iterate>
                                      </logic:present>
                                  </table>
                              </td>
                          </tr>                            
                          </table>
                        <table width="686" border="1" bordercolor="#D7E5F2" class="regsitertable">
                          <tr style="border: #528B8B 4px solid">
                            <td width="20%" bgcolor="#CCCCCC" class="right">SCHOOLED </td>
                            <td width="75%" colspan="2" bgcolor="#CCCCCC"> </td>
                          </tr>
                          <tr>
                              <!---->
                            <td rowspan="7"> </td>
                            <td width="4%"><html:multibox property="schoolServices" value="12e" styleClass="smallfieldcellselect" styleId="12e"/></td>
                            <td>Sensitization for child school enrolment/re-enrolment</td>
                          </tr>
                          <tr>
                            <td width="4%"><html:multibox property="schoolServices" value="11e" styleClass="smallfieldcellselect" styleId="11e"/></td>
                            <td> Referral for educational services </td>
                          </tr>
                          <tr>
                              <td colspan="2">
                                  <table>
                                      <logic:present name="otherCaregiverSchoolList">
                                          <logic:iterate name="otherCaregiverSchoolList" id="service">
                                          <tr>
                                              <td><html:multibox property="schoolServices" value="${service.serviceCode}" styleClass="smallfieldcellselect" styleId="${service.serviceCode}"/></td>
                                                <td>${service.serviceName}</td>
                                          </tr>
                                          </logic:iterate>
                                      </logic:present>
                                  </table>
                              </td>
                           </tr>
                        </table>
                         
                        <table width="686" border="1" bordercolor="#D7E5F2" class="regsitertable">
                          <tr style="border: #528B8B 4px solid">
                            <td width="20%" bgcolor="#CCCCCC" class="right">STABLE </td>
                            <td width="75%" colspan="2" bgcolor="#CCCCCC"> </td>
                          </tr>
                          <tr>
                            <td rowspan="11"></td>
                            <td width="4%"><html:multibox property="stableServices" value="1es" styleClass="smallfieldcellselect" styleId="1es"/></td>
                            <td>Financial Education</td>
                          </tr>
                          <tr>
                            
                            <td width="4%"><html:multibox property="stableServices" value="2es" styleClass="smallfieldcellselect" styleId="2es"/></td>
                            <td>Access to Micro-finance</td>
                          </tr>
                          <tr>
                            
                            <td width="4%"><html:multibox property="stableServices" value="3es" styleClass="smallfieldcellselect" styleId="3es"/></td>
                            <td>Vocational/apprenticeship training </td>
                          </tr>
                          <tr>
                            <td width="4%"><html:multibox property="stableServices" value="9t" styleClass="smallfieldcellselect" styleId="9t"/></td>
                            <td>Agricultural inputs/agricultural value chain</td>
                          </tr>

                          <tr>
                              <td width="4%"><html:multibox property="stableServices" value="12t" styleClass="smallfieldcellselect" styleId="12t"/></td>
                            <td>Home gardening support</td>
                          </tr>
                          <tr>
                              <td width="4%"><html:multibox property="stableServices" value="6es" styleClass="smallfieldcellselect" styleId="6es"/></td>
                            <td>Cash transfer scheme</td>
                          </tr>
                          <tr>
                              <td width="4%"><html:multibox property="stableServices" value="8es" styleClass="smallfieldcellselect" styleId="8es"/></td>
                            <td>Savings group (SILC, VSLA etc.)</td>
                          </tr>
                          <tr>
                              <td width="4%"><html:multibox property="stableServices" value="10t" styleClass="smallfieldcellselect" styleId="10t"/></td>
                            <td>Short-term emergency cash support</td>
                          </tr>
                          <tr>
                              <td width="4%"><html:multibox property="stableServices" value="11t" styleClass="smallfieldcellselect" styleId="11t"/></td>
                            <td>Safe shelter-related repair or construction</td>
                          </tr>
                          
                          <tr>
                              <td width="4%"><html:multibox property="stableServices" value="13t" styleClass="smallfieldcellselect" styleId="13t"/></td>
                            <td>Referral for stable services</td>
                          </tr>
                          <tr>
                              <td colspan="2">
                                  <table>
                                      <logic:present name="otherCaregiverStableList">
                                          <logic:iterate name="otherCaregiverStableList" id="service">
                                          <tr>
                                              <td><html:multibox property="stableServices" value="${service.serviceCode}" styleClass="smallfieldcellselect" styleId="${service.serviceCode}"/></td>
                                                <td>${service.serviceName}</td>
                                          </tr>
                                          </logic:iterate>
                                      </logic:present>
                                  </table>
                              </td>
                          </tr>
                        </table>  
                       
                      </td>
                      </tr>
                  </table>
                  </fieldset>

                  </td>
                </tr>
                <tr>
                  <td>Completed by </td>
                <td > 
                    <html:select property="volunteerName" styleId="volunteerName" style="width:200px;" >
                          <%--<html:option value="select">select...</html:option>--%>
                          <html:option value="xxxxxxxxxxx">None</html:option>
                          <logic:present name="enumeratorList">
                              <logic:iterate name="enumeratorList" id="er">
                                <html:option value="${er.communityWorkerId}">${er.firstName} ${er.surname}</html:option>
                              </logic:iterate>

                          </logic:present>
                      </html:select>
                </td>

                <td  align="right"> </td>
                <td > 

                </td>
              </tr>
               
                                    <tr><td colspan="4" align="center"><html:submit value="Save" onclick="setActionName('save')" disabled="${hhsSaveDisabled}"/>
                                            <html:submit value="Modify" onclick="return confirmAction('modify')" disabled="${hhsModifyDisabled}"/>
                                        <html:submit value="Delete" onclick="return confirmAction('delete')" disabled="${hhsModifyDisabled}"/></td></tr>
                                    
                                    <%--<tr><td colspan="4" style="height: 400px;">&nbsp;</td></tr>--%> 
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
</table>
  </body>
</html>
