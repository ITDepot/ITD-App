
package com.patrick.itdepot.framework.getinstallpendding;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class GetinstallPendding {

    @SerializedName("user_id")
    @Expose
    private String userId;
    @SerializedName("client_name")
    @Expose
    private String clientName;
    @SerializedName("service")
    @Expose
    private String service;
    @SerializedName("nr_income")
    @Expose
    private String nrIncome;
    @SerializedName("mr_income")
    @Expose
    private String mrIncome;
    @SerializedName("est_install")
    @Expose
    private String estInstall;
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
     *     The estInstall
     */
    public String getEstInstall() {
        return estInstall;
    }

    /**
     * 
     * @param estInstall
     *     The est_install
     */
    public void setEstInstall(String estInstall) {
        this.estInstall = estInstall;
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
