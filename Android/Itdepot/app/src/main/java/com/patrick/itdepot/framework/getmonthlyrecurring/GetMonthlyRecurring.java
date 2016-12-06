
package com.patrick.itdepot.framework.getmonthlyrecurring;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class GetMonthlyRecurring {

    @SerializedName("user_id")
    @Expose
    private String userId;
    @SerializedName("client_name")
    @Expose
    private String clientName;
    @SerializedName("service")
    @Expose
    private String service;
    @SerializedName("mr_income")
    @Expose
    private String mrIncome;
    @SerializedName("date_started")
    @Expose
    private String dateStarted;
    @SerializedName("date_end")
    @Expose
    private String dateEnd;
    @SerializedName("status")
    @Expose
    private String status;
    @SerializedName("created_at")
    @Expose
    private String createdAt;
    @SerializedName("updated_at")
    @Expose
    private String updatedAt;
    @SerializedName("mr_income_total")
    @Expose
    private String mrIncomeTotal;

    /**
     * 
     * @return
     *     The userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * 
     * @param userId
     *     The user_id
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * 
     * @return
     *     The clientName
     */
    public String getClientName() {
        return clientName;
    }

    /**
     * 
     * @param clientName
     *     The client_name
     */
    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    /**
     * 
     * @return
     *     The service
     */
    public String getService() {
        return service;
    }

    /**
     * 
     * @param service
     *     The service
     */
    public void setService(String service) {
        this.service = service;
    }

    /**
     * 
     * @return
     *     The mrIncome
     */
    public String getMrIncome() {
        return mrIncome;
    }

    /**
     * 
     * @param mrIncome
     *     The mr_income
     */
    public void setMrIncome(String mrIncome) {
        this.mrIncome = mrIncome;
    }

    /**
     * 
     * @return
     *     The dateStarted
     */
    public String getDateStarted() {
        return dateStarted;
    }

    /**
     * 
     * @param dateStarted
     *     The date_started
     */
    public void setDateStarted(String dateStarted) {
        this.dateStarted = dateStarted;
    }

    /**
     * 
     * @return
     *     The dateEnd
     */
    public String getDateEnd() {
        return dateEnd;
    }

    /**
     * 
     * @param dateEnd
     *     The date_end
     */
    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }

    /**
     * 
     * @return
     *     The status
     */
    public String getStatus() {
        return status;
    }

    /**
     * 
     * @param status
     *     The status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * 
     * @return
     *     The createdAt
     */
    public String getCreatedAt() {
        return createdAt;
    }

    /**
     * 
     * @param createdAt
     *     The created_at
     */
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * 
     * @return
     *     The updatedAt
     */
    public String getUpdatedAt() {
        return updatedAt;
    }

    /**
     * 
     * @param updatedAt
     *     The updated_at
     */
    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    /**
     * 
     * @return
     *     The mrIncomeTotal
     */
    public String getMrIncomeTotal() {
        return mrIncomeTotal;
    }

    /**
     * 
     * @param mrIncomeTotal
     *     The mr_income_total
     */
    public void setMrIncomeTotal(String mrIncomeTotal) {
        this.mrIncomeTotal = mrIncomeTotal;
    }

}
