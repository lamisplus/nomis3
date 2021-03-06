<%-- 
    Document   : PrCgDateOfBirthFile
    Created on : Feb 14, 2019, 7:24:53 PM
    Author     : smomoh
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<table>
    <tr>
        <td>
            <html:select property="prDayOfBirth" styleId="prDayOfBirth">
                <html:option value="0">Day</html:option>
                <logic:present name="hhpDayList">
                    <logic:iterate name="hhpDayList" id="day">
                        <html:option value="${day}">${day}</html:option>
                    </logic:iterate>
                </logic:present>
            </html:select>
            <html:select property="prMonthOfBirth" styleId="prMonthOfBirth" onchange="getDaysPerMonth(this.value,'prDayOfBirth')">
                <html:option value="0">Month</html:option>
                <logic:present name="hhpMonthList">
                    <logic:iterate name="hhpMonthList" id="month">
                        <html:option value="${month.value}">${month.name}</html:option>
                    </logic:iterate>
                </logic:present>
            </html:select>
            <html:select property="prYearOfBirth" styleId="prYearOfBirth">
                <html:option value="0">Year</html:option>
                <logic:present name="hhpYearList">
                    <logic:iterate name="hhpYearList" id="year">
                        <html:option value="${year}">${year}</html:option>
                    </logic:iterate>
                </logic:present>
            </html:select>
        </td>
    </tr>
</table>
