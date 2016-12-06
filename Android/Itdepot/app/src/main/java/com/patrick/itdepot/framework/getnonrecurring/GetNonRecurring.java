
package com.patrick.itdepot.framework.getnonrecurring;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class GetNonRecurring {

    @SerializedName("agent_uniq_id")
    @Expose
    private String agentUniqId;
    @SerializedName("agent_id")
    @Expose
    private String agentId;
    @SerializedName("client_name")
    @Expose
    private String clientName;
    @SerializedName("service")
    @Expose
    private String service;
    @SerializedName("nr_income")
    @Expose
    private String nrIncome;
    @SerializedName("date_paid")
    @Expose
    private String datePaid;
    @SerializedName("status")
    @Expose
    private String status;
    @SerializedName("created_at")
    @Expose
    private String createdAt;
    @SerializedName("updated_at")
    @Expose
    private String updatedAt;
    @SerializedName("nr_income_total")
    @Expose
    private String nrIncomeTotal;

    /**
     * 
     * @return
     *     The agentUniqId
     */
    public String getAgentUniqId() {
        return agentUniqId;
    }

    /**
     * 
     * @param agentUniqId
     *     The agent_uniq_id
     */
    public void setAgentUniqId(String agentUniqId) {
        this.agentUniqId = agentUniqId;
    }

    /**
     * 
     * @return
     *     The agentId
     */
    public String getAgentId() {
        return agentId;
    }

    /**
     * 
     * @param agentId
     *     The agent_id
     */
    public void setAgentId(String agentId) {
        this.agentId = agentId;
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
     *     The nrIncome
     */
    public String getNrIncome() {
        return nrIncome;
    }

    /**
     * 
     * @param nrIncome
     *     The nr_income
     */
    public void setNrIncome(String nrIncome) {
        this.nrIncome = nrIncome;
    }

    /**
     * 
     * @return
     *     The datePaid
     */
    public String getDatePaid() {
        return datePaid;
    }

    /**
     * 
     * @param datePaid
     *     The date_paid
     */
    public void setDatePaid(String datePaid) {
        this.datePaid = datePaid;
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
     *     The nrIncomeTotal
     */
    public String getNrIncomeTotal() {
        return nrIncomeTotal;
    }

    /**
     * 
     * @param nrIncomeTotal
     *     The nr_income_total
     */
    public void setNrIncomeTotal(String nrIncomeTotal) {
        this.nrIncomeTotal = nrIncomeTotal;
    }

}
