/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nomis.ovc.dao;

import com.nomis.ovc.business.AdultHouseholdMember;
import com.nomis.ovc.business.BeneficiaryStatusUpdate;
import com.nomis.ovc.business.Ovc;
import com.nomis.ovc.util.AppConstant;
import com.nomis.ovc.util.DateManager;
import com.nomis.reports.utils.ReportParameterTemplate;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author smomoh
 */
public class BeneficiaryStatusUpdateDaoImpl implements BeneficiaryStatusUpdateDao
{
   Session session;
    Transaction tx;
    SessionFactory sessions;
    String markedForDeleteQuery=" and bsu.markedForDelete=0";
    public void deleteHivStatusRecordsOfChildrenAtRiskOfHivBeforeOctober2018() throws Exception
    {
        String query="delete from APP.BeneficiaryStatusUpdate where newhivstatus="+AppConstant.HIV_TEST_REQUIRED_NUM+" and dateofnewstatus <'2018-10-01'";
        session = HibernateUtil.getSession();
        tx = session.beginTransaction();
        session.createSQLQuery(query).executeUpdate();
        tx.commit();
        closeSession(session);
    }
    public void saveBeneficiaryStatusUpdate(BeneficiaryStatusUpdate bsu,boolean updateBeneficiaryHivStatus) throws Exception
    {
        try
        {
            if(bsu !=null)
            {
                if(this.getBeneficiaryStatusUpdate(bsu.getBeneficiaryId())==null)
                {
                    bsu=getCleanedBeneficiaryStatusUpdate(bsu);
                    System.err.println("bsu.getBeneficiaryId in saveBeneficiaryStatusUpdate is "+bsu.getBeneficiaryId());
                    System.err.println("bsu.getNewHivStatus() in saveBeneficiaryStatusUpdate is "+bsu.getNewHivStatus());
                    session = HibernateUtil.getSession();
                    tx = session.beginTransaction();
                    session.save(bsu);
                    tx.commit();
                    closeSession(session);
                    if(updateBeneficiaryHivStatus)
                    {
                        updateBeneficiaryCurrentHivStatus(bsu);
                        saveHivStatusHistory(bsu);
                    }
                }
                else
                {
                    updateBeneficiaryStatusUpdate(bsu,updateBeneficiaryHivStatus);
                }
            }
        }
        catch(Exception ex)
        {
          closeSession(session);  
          ex.printStackTrace();
        }
    }
    public void updateBeneficiaryStatusUpdate(BeneficiaryStatusUpdate bsu,boolean updateBeneficiaryHivStatus) throws Exception
    {
        try
        {
            System.err.println("Inside updateBeneficiaryStatusUpdate ");
            if(bsu !=null)
            {
                //System.err.println(" ID is "+bsu.getBeneficiaryId()+" "+bsu.getFirstName()+" bsu.getNewHivStatus() "+bsu.getNewHivStatus()+" "+bsu.getDateOfNewStatus());
                System.err.println("bsu.getCaregiverHivStatus()1 is "+bsu.getCaregiverHivStatus());
                BeneficiaryStatusUpdate bsu2=this.getBeneficiaryStatusUpdate(bsu.getBeneficiaryId());
                if(bsu2 !=null)
                {
                    System.err.println("bsu.getCaregiverHivStatus()2 is "+bsu.getCaregiverHivStatus());
                    saveHivStatusHistory(bsu2);
                    //System.err.println("bsu.getLastHivStatus() "+bsu.getLastHivStatus()+" bsu.getNewHivStatus() is "+bsu.getNewHivStatus());
                    bsu.setDateCreated(bsu2.getDateCreated());
                    if((bsu.getDateOfNewStatus().equals(bsu2.getDateOfNewStatus())) || bsu.getDateOfNewStatus().after(bsu2.getDateOfNewStatus()))
                    {
                        System.err.println("bsu.getCaregiverHivStatus()3 is "+bsu.getCaregiverHivStatus());
                        if(bsu.getNewHivStatus()==AppConstant.HIV_POSITIVE_NUM && bsu.getEnrolledOnTreatment()==0)
                        {
                            bsu.setEnrolledOnTreatment(bsu2.getEnrolledOnTreatment());
                            bsu.setFacilityId(bsu2.getFacilityId());
                        }
                        
                        System.err.println(bsu.getNewHivStatus()+" HIV status updated ");
                        
                    }
                    System.err.println("bsu.getCaregiverHivStatus()4 is "+bsu.getCaregiverHivStatus());
                    bsu=getCleanedBeneficiaryStatusUpdate(bsu);
                    session = HibernateUtil.getSession();
                    tx = session.beginTransaction();
                    session.update(bsu);
                    tx.commit();
                    closeSession(session);
                    if(updateBeneficiaryHivStatus)
                    {
                        System.err.println("bsu.getCaregiverHivStatus()5 is "+bsu.getCaregiverHivStatus());
                        updateBeneficiaryCurrentHivStatus(bsu);
                        saveHivStatusHistory(bsu);
                    }
                }
                else
                {
                    saveBeneficiaryStatusUpdate(bsu,updateBeneficiaryHivStatus);
                }
            }
        }
        catch(Exception ex)
        {
          closeSession(session);  
          ex.printStackTrace();
        }
    }
    public void markForDelete(BeneficiaryStatusUpdate bsu) throws Exception
    {
        try
        {
            //System.err.println("Inside updateBeneficiaryStatusUpdate ");
            if(bsu !=null)
            {
                //System.err.println(" ID is "+bsu.getBeneficiaryId()+" "+bsu.getFirstName()+" bsu.getNewHivStatus() "+bsu.getNewHivStatus()+" "+bsu.getDateOfNewStatus());
                BeneficiaryStatusUpdate bsu2=this.getBeneficiaryStatusUpdate(bsu.getBeneficiaryId());
                if(bsu2 !=null)
                {
                    bsu2.setMarkedForDelete(AppConstant.MARKEDFORDELETE);
                    session = HibernateUtil.getSession();
                    tx = session.beginTransaction();
                    session.update(bsu2);
                    tx.commit();
                    closeSession(session);
                }
                
            }
        }
        catch(Exception ex)
        {
          closeSession(session);  
          ex.printStackTrace();
        }
    }
    public void deleteBeneficiaryStatusUpdate(BeneficiaryStatusUpdate bsu) throws Exception
    {
        try
        {
            if(bsu !=null && this.getBeneficiaryStatusUpdate(bsu.getBeneficiaryId()) !=null)
            {
                session = HibernateUtil.getSession();
                tx = session.beginTransaction();
                session.delete(bsu);
                tx.commit();
                closeSession(session);
            }
        }
        catch(Exception ex)
        {
          closeSession(session);  
          ex.printStackTrace();
        }
    }
    public void deleteBeneficiaryStatusUpdate(String beneficiarId) throws Exception
    {
        try
        {
            BeneficiaryStatusUpdate bsu=getBeneficiaryStatusUpdate(beneficiarId);
            if(bsu !=null)
            {
                deleteBeneficiaryStatusUpdate(bsu);
            }
        }
        catch(Exception ex)
        {
          ex.printStackTrace();
        }
    }
    public  BeneficiaryStatusUpdate getBeneficiaryStatusUpdate(String beneficiaryId) throws Exception
    {
        BeneficiaryStatusUpdate bsu=null;
        session = HibernateUtil.getSession();
        tx = session.beginTransaction();
        List list = session.createQuery("from BeneficiaryStatusUpdate bsu where bsu.beneficiaryId=:id").setString("id", beneficiaryId).list();
        tx.commit();
        closeSession(session);
        if(list !=null && !list.isEmpty())
        {
            bsu=(BeneficiaryStatusUpdate)list.get(0);
        }
        return bsu;
    }
    public List getBeneficiaryStatusUpdateRecordsForExport(ReportParameterTemplate rpt) throws Exception
    {
        List mainList=new ArrayList();
        try
        {
            mainList.addAll(getOvcStatusUpdateRecordsForExport(rpt));
            mainList.addAll(getAdultHouseholdMemberStatusUpdateRecordsForExport(rpt));
        }
         catch (Exception ex)
         {
             closeSession(session);
            throw new Exception(ex);
         }
        return mainList;
    }
    public List getOvcStatusUpdateRecordsForExport(ReportParameterTemplate rpt) throws Exception
    {
        List mainList=new ArrayList();
        try
        {
            SubQueryGenerator sqg=new SubQueryGenerator();
            String additionalOrgUnitQuery="";
            if(rpt !=null && rpt.getLevel2OuId() !=null && rpt.getLevel2OuId().trim().length()>0 && !rpt.getLevel2OuId().equalsIgnoreCase("select") && !rpt.getLevel2OuId().equalsIgnoreCase("All"))
            {
                additionalOrgUnitQuery=sqg.getOrganizationUnitQuery(rpt);
            }
            String query=SubQueryGenerator.getHheOvcOrganizationUnitBeneficiaryStatusUpdateQuery()+additionalOrgUnitQuery+sqg.getBeneficiaryStatusUpdateLastModifiedDateQuery(rpt.getStartDate(),rpt.getEndDate());
            System.err.println(query);
            session = HibernateUtil.getSession();
            tx = session.beginTransaction();
            List list = session.createQuery(query).list();
            tx.commit();
            closeSession(session);
            if(list !=null)
            {
                for(Object obj:list)
                {
                    Object[] objArray=(Object[])obj;
                    mainList.add(objArray[3]);
                }
            }
        }
         catch (Exception ex)
         {
             closeSession(session);
            throw new Exception(ex);
         }
        return mainList;
    }
    public List getAdultHouseholdMemberStatusUpdateRecordsForExport(ReportParameterTemplate rpt) throws Exception
    {
        List mainList=new ArrayList();
        try
        {
            SubQueryGenerator sqg=new SubQueryGenerator();
            String additionalOrgUnitQuery="";
            if(rpt !=null && rpt.getLevel2OuId() !=null && rpt.getLevel2OuId().trim().length()>0 && !rpt.getLevel2OuId().equalsIgnoreCase("select") && !rpt.getLevel2OuId().equalsIgnoreCase("All"))
            {
                additionalOrgUnitQuery=sqg.getOrganizationUnitQuery(rpt);
            }
            String query=SubQueryGenerator.getHheAdultHouseholdMemberOrganizationUnitBeneficiaryStatusUpdateQuery()+additionalOrgUnitQuery+sqg.getBeneficiaryStatusUpdateLastModifiedDateQuery(rpt.getStartDate(),rpt.getEndDate());
            System.err.println(query);
            session = HibernateUtil.getSession();
            tx = session.beginTransaction();
            List list = session.createQuery(query).list();
            tx.commit();
            closeSession(session);
            if(list !=null)
            {
                for(Object obj:list)
                {
                    Object[] objArray=(Object[])obj;
                    mainList.add(objArray[3]);
                }
            }
        }
         catch (Exception ex)
         {
             closeSession(session);
            throw new Exception(ex);
         }
        return mainList;
    }
    public  List getAllBeneficiaryStatusUpdateRecords() throws Exception
    {
        List list=null;
        try
        {
            session = HibernateUtil.getSession();
            tx = session.beginTransaction();
            list = session.createQuery("from BeneficiaryStatusUpdate bsu"+markedForDeleteQuery).list();
            tx.commit();
            closeSession(session);  
        }
         catch (Exception ex)
         {
             closeSession(session);
            throw new Exception(ex);
         }
        return list;
    }
    private void updateBeneficiaryCurrentHivStatus(BeneficiaryStatusUpdate bsu) throws Exception
    {
        if(bsu !=null)
        {
            System.err.println("bsu.getCaregiverHivStatus() in  updateBeneficiaryCurrentHivStatus() is "+bsu.getCaregiverHivStatus());
            System.err.println("bsu.getCaregiverEnrolledOnTreatment() in  updateBeneficiaryCurrentHivStatus() is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment() is "+bsu.getDateCaregiverEnrolledOnTreatment());
            //System.err.println(" ID is "+bsu.getBeneficiaryId()+" "+bsu.getFirstName()+" bsu.getNewHivStatus() "+bsu.getNewHivStatus()+" "+bsu.getDateOfNewStatus());
            EnrollmentStatusHistoryDao eshdao=new EnrollmentStatusHistoryDaoImpl();
            if(bsu.getUpdateChildBirthRegStatus()==1 || bsu.getUpdateChildHivStatus()==1)
            {
                ChildEnrollmentDao dao=new ChildEnrollmentDaoImpl();
                Ovc ovc=dao.getOvc(bsu.getBeneficiaryId());
                if(ovc !=null)
                {
                    if(bsu.getUpdateChildHivStatus()==1)
                    {
                        System.err.println("Ovc is not null in bsu dao");
                        if(bsu.getDateOfNewStatus()==null)
                        bsu.setDateOfNewStatus(bsu.getDateOfLastHivStatus());
                        if(bsu.getDateOfNewStatus() !=null)
                        {
                            System.err.println(" bsu.getDateOfNewStatus() "+bsu.getDateOfNewStatus()+" is not null");
                            if(ovc.getDateOfCurrentHivStatus() !=null)
                            {
                                //if(DateManager.compareDates(ovc.getDateOfCurrentHivStatus(), bsu.getDateOfNewStatus()))
                                if((ovc.getDateOfCurrentHivStatus().equals(bsu.getDateOfNewStatus())) || (ovc.getDateOfCurrentHivStatus().before(bsu.getDateOfNewStatus())))
                                {
                                    ovc.setCurrentHivStatus(bsu.getNewHivStatus());
                                    ovc.setDateOfCurrentHivStatus(bsu.getDateOfNewStatus());
                                    if(ovc.getCurrentHivStatus()==AppConstant.HIV_POSITIVE_NUM)
                                    {
                                         ovc.setEnrolledOnTreatment(bsu.getEnrolledOnTreatment());
                                         ovc.setHivTreatmentFacilityId(bsu.getFacilityId());
                                         ovc.setDateEnrolledOnTreatment(bsu.getDateEnrolledOnTreatment());
                                         ovc.setTreatmentId(bsu.getChildTreatmentId());
                                    }
                                    else
                                    {
                                        //if not on treatment, reset all treatment related fields to default
                                         ovc.setEnrolledOnTreatment(0);
                                         ovc.setHivTreatmentFacilityId(null);
                                         ovc.setDateEnrolledOnTreatment(DateManager.getDefaultStartDateInstance());
                                         ovc.setTreatmentId(null);
                                    }
                                    dao.updateOvc(ovc, false, false);
                                    System.err.println("ovc.getDateOfCurrentHivStatus() is "+ovc.getDateOfCurrentHivStatus()+" "+ovc.getCurrentHivStatus());
                                }
                            }
                            else
                            {
                                ovc.setCurrentHivStatus(bsu.getNewHivStatus());
                                ovc.setDateOfCurrentHivStatus(bsu.getDateOfNewStatus());
                                System.err.println("ovc.getDateOfCurrentHivStatus() 2 is "+ovc.getDateOfCurrentHivStatus()+" ovc.getCurrentHivStatus() is "+ovc.getCurrentHivStatus());
                            }
                            if(ovc.getCurrentHivStatus()==AppConstant.HIV_POSITIVE_NUM)
                            {
                                ovc.setEnrolledOnTreatment(bsu.getEnrolledOnTreatment());
                                ovc.setHivTreatmentFacilityId(bsu.getFacilityId());
                            }
                            //at this stage ovc.getDateOfCurrentHivStatus() is expected to be equal to bsu.getDateOfNewStatus()
                            if((ovc.getDateOfCurrentHivStatus().equals(bsu.getDateOfNewStatus())))
                            dao.updateOvc(ovc, false, false);
                            //Update the HIV status for the quarter if the beneficiary has enrollment status record for that quarter
                            eshdao.updateHivStatus(ovc.getOvcId(), ovc.getCurrentHivStatus(), ovc.getDateOfCurrentHivStatus(), ovc.getCurrentAge(),ovc.getCurrentAgeUnit());
                        }
                    }
                    //If the user request that birth certificate information be updated, then update
                    if(bsu.getUpdateChildBirthRegStatus()==1)
                    {
                        //Only update current birth registration status if the child has no birth certificate
                        if(ovc.getCurrentBirthRegistrationStatus() !=AppConstant.CHILD_HAS_BIRTHCERTIFICATE && bsu.getBirthCertificate()==AppConstant.CHILD_HAS_BIRTHCERTIFICATE)
                        {
                            ovc.setCurrentBirthRegistrationStatus(bsu.getBirthCertificate());
                            ovc.setDateOfCurrentBirthRegStatus(bsu.getLastModifiedDate());
                        }
                        
                        ovc.setCurrentSchoolStatus(bsu.getSchoolStatus());
                        if(bsu.getSchoolStatus()==AppConstant.CHILD_IN_SCHOOL)
                        {
                            ovc.setSchoolName(bsu.getSchoolName());
                            ovc.setSchoolGrade(bsu.getGrade());
                            ovc.setDateOfCurrentSchoolStatus(bsu.getLastModifiedDate());
                        }
                        else if(bsu.getEnrolledInVocationalTraining()==AppConstant.CHILD_IN_SCHOOL)
                        {
                            ovc.setCurrentSchoolStatus(bsu.getEnrolledInVocationalTraining());
                            ovc.setSchoolName(bsu.getNameOfVocationalTraining());
                            ovc.setDateOfCurrentSchoolStatus(bsu.getLastModifiedDate());
                        }
                        
                    }
                    /*if(bsu.getUpdateChildBirthRegStatus()==1)
                    {
                        if(ovc.getCurrentBirthRegistrationStatus() !=1)
                        {
                            ovc.setCurrentBirthRegistrationStatus(bsu.getBirthCertificate());
                            ovc.setDateOfCurrentBirthRegStatus(bsu.getLastModifiedDate());
                        }
                    }*/
                }
            }
            //else
            //{
            if(bsu.getUpdateCaregiverHivStatus()==1)
            {
                //System.err.println("About to update ahm in bsu dao");
                AdultHouseholdMemberDao ahmdao=new AdultHouseholdMemberDaoImpl();
                AdultHouseholdMember ahm=ahmdao.getAdultHouseholdMember(bsu.getCaregiverId());
                if(ahm !=null)
                {
                    System.err.println("ahm is not null in bsu dao");
                    //System.err.println("bsu.getCaregiverEnrolledOnTreatment()2 in  updateBeneficiaryCurrentHivStatus() is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment() is "+bsu.getDateCaregiverEnrolledOnTreatment());
                    if(bsu.getDateOfCaregiverHivStatus()==null)
                    bsu.setDateOfCaregiverHivStatus(bsu.getDateOfLastHivStatus());
                    if(bsu.getDateOfCaregiverHivStatus() !=null)
                    {
                        //System.err.println("bsu.getCaregiverEnrolledOnTreatment() in  updateBeneficiaryCurrentHivStatus() is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment()3 is "+bsu.getDateCaregiverEnrolledOnTreatment());
                        //System.err.println("bsu.getDateOfCaregiverHivStatus() is not null in bsu dao");
                        if(ahm.getDateOfCurrentHivStatus() !=null)
                        {
                            //System.err.println("bsu.getCaregiverEnrolledOnTreatment()4 in  updateBeneficiaryCurrentHivStatus() is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment() is "+bsu.getDateCaregiverEnrolledOnTreatment());
                            //System.err.println("ahm.getDateOfCurrentHivStatus() is not null in bsu dao");
                            //If the date of current HIV status precedes the date new HIV status, update the current HIV status for beneficiary
                            if((ahm.getDateOfCurrentHivStatus().equals(bsu.getDateOfCaregiverHivStatus())) || (ahm.getDateOfCurrentHivStatus().before(bsu.getDateOfCaregiverHivStatus())))
                            {
                                {
                                    ahm.setCurrentHivStatus(bsu.getCaregiverHivStatus());
                                    ahm.setDateOfCurrentHivStatus(bsu.getDateOfCaregiverHivStatus());
                                    
                                }
                            }
                        }
                        else
                        {
                            //System.err.println("setting ahm.setCurrentHivStatus(bsu.getNewHivStatus()) in bsu dao");
                            ahm.setCurrentHivStatus(bsu.getCaregiverHivStatus());
                            ahm.setDateOfCurrentHivStatus(bsu.getDateOfCaregiverHivStatus());
                        }
                        if(ahm.getCurrentHivStatus()==AppConstant.HIV_POSITIVE_NUM)
                        {
                            //if current HIV status is positive, update treatment related information
                            //System.err.println("bsu.getCaregiverEnrolledOnTreatment() in  updateBeneficiaryCurrentHivStatus()5 is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment() is "+bsu.getDateCaregiverEnrolledOnTreatment());
                            //System.err.println("setting ahm.setEnrolledOnTreatment(bsu.getEnrolledOnTreatment()); in bsu dao");
                            ahm.setEnrolledOnTreatment(bsu.getCaregiverEnrolledOnTreatment());
                            ahm.setHivTreatmentFacilityId(bsu.getFacilityCaregiverEnrolled());
                            ahm.setDateEnrolledOnTreatment(bsu.getDateCaregiverEnrolledOnTreatment());
                            ahm.setTreatmentId(bsu.getCaregiverTreatmentId());
                        }
                        else
                        {
                            ahm.setEnrolledOnTreatment(0);
                            ahm.setHivTreatmentFacilityId(null);
                            ahm.setDateEnrolledOnTreatment(DateManager.getDefaultStartDateInstance());
                            ahm.setTreatmentId(null);
                        }
                        //System.err.println("bsu.getCaregiverEnrolledOnTreatment() in  updateBeneficiaryCurrentHivStatus()6 is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment() is "+bsu.getDateCaregiverEnrolledOnTreatment());
                        
                        if((ahm.getDateOfCurrentHivStatus().equals(bsu.getDateOfCaregiverHivStatus())))
                        {
                            //if the date of current HIV status is same as date of new HIV status, then update beneficiary HIV status
                            ahmdao.updateAdultHouseholdMember(ahm);
                            //System.err.println("bsu.getCaregiverEnrolledOnTreatment() in  updateBeneficiaryCurrentHivStatus()7 is "+bsu.getCaregiverEnrolledOnTreatment()+" and bsu.getDateCaregiverEnrolledOnTreatment() is "+bsu.getDateCaregiverEnrolledOnTreatment());
                            //System.err.println("setting ahmdao.updateAdultHouseholdMember(ahm) in bsu dao");
                        }
                        
                        //Update the HIV status for the quarter if the beneficiary has enrollment status record for that quarter
                        eshdao.updateHivStatus(ahm.getBeneficiaryId(), ahm.getCurrentHivStatus(), ahm.getDateOfCurrentHivStatus(), ahm.getCurrentAge(),AppConstant.AGEUNIT_YEAR_NUM);
                    }
                }
                    //System.err.println("ahm.getEnrolledOnTreatment() is "+ahm.getEnrolledOnTreatment());
                }
            //}
        }
    }
    public void changeBeneficiaryIdInBeneficiaryStatusUpdate(String oldOvcId, String newOvcId) throws Exception
    {
        BeneficiaryStatusUpdate bsu=this.getBeneficiaryStatusUpdate(oldOvcId);
        if(bsu !=null)
        {
            /*HivStatusHistoryDao hshdao=new HivStatusHistoryDaoImpl();
            bsu.setBeneficiaryId(newOvcId);
            if(getBeneficiaryStatusUpdate(bsu.getBeneficiaryId())==null)
            saveBeneficiaryStatusUpdate(bsu, false);
            else
            updateBeneficiaryStatusUpdate(bsu, false);
            
            bsu.setBeneficiaryId(oldOvcId);
            this.deleteBeneficiaryStatusUpdate(bsu);
            hshdao.changeBeneficiaryIdInHivStatusHistory(oldOvcId, newOvcId);
            System.err.println("OVC Id in BeneficiaryStatusUpdate changed from "+oldOvcId+" to "+newOvcId);*/
        }
    }
    public void saveHivStatusHistory(BeneficiaryStatusUpdate bsu) throws Exception
    {
        if(bsu !=null)
        {
            /*HivStatusHistory hsh=new HivStatusHistory();
            hsh.setBeneficiaryId(bsu.getBeneficiaryId());
            hsh.setBeneficiaryTypeValue(bsu.getBeneficiaryTypeValue());
            hsh.setDateCreated(bsu.getDateCreated());
            hsh.setDateOfNewStatus(bsu.getDateOfNewStatus());
            hsh.setEnrolledOnTreatment(bsu.getEnrolledOnTreatment());
            hsh.setFacilityId(bsu.getFacilityId());
            hsh.setLastModifiedDate(bsu.getLastModifiedDate());
            hsh.setNewHivStatus(bsu.getNewHivStatus());
            hsh.setPointOfUpdateValue(bsu.getPointOfUpdateValue());
            hsh.setRecordedBy(bsu.getRecordedBy());
            HivStatusHistoryDao hshdao=new HivStatusHistoryDaoImpl();
            hshdao.saveHivStatusHistory(hsh);*/
        }
    }
    private BeneficiaryStatusUpdate getCleanedBeneficiaryStatusUpdate(BeneficiaryStatusUpdate bsu)
    {
        if(bsu !=null)
        {
            if(bsu.getDateCreated()==null && bsu.getLastModifiedDate() !=null)
            bsu.setDateCreated(bsu.getLastModifiedDate());
            else if(bsu.getLastModifiedDate()==null && bsu.getDateCreated() !=null)
            bsu.setLastModifiedDate(bsu.getDateCreated());
            else if(bsu.getLastModifiedDate()==null && bsu.getDateCreated()==null)
            {
                bsu.setDateCreated(DateManager.getCurrentDateInstance());
                bsu.setLastModifiedDate(DateManager.getCurrentDateInstance());
            }
        }
        return bsu;
    }
    public void closeSession(Session session)
    {
        if(session !=null && session.isOpen())
        {
            session.close();
        }
    } 
}
