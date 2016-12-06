
package com.patrick.itdepot.framework.contactclient;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class ContactClientRequest {

    @SerializedName("user_id")
    @Expose
    private String userId;
    @SerializedName("service")
    @Expose
    private String service;
    @SerializedName("business_name")
    @Expose
    private String businessName;
    @SerializedName("contact_name")
    @Expose
    private String contactName;
    @SerializedName("contact_phone")
    @Expose
    private String contactPhone;
    @SerializedName("contact_email")
    @Expose
    private String contactEmail;
    @SerializedName("message")
    @Expose
    private String message;

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
     *     The businessName
     */
    public String getBusinessName() {
        return businessName;
    }

    /**
     * 
     * @param businessName
     *     The business_name
     */
    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    /**
     * 
     * @return
     *     The contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * 
     * @param contactName
     *     The contact_name
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * 
     * @return
     *     The contactPhone
     */
    public String getContactPhone() {
        return contactPhone;
    }

    /**
     * 
     * @param contactPhone
     *     The contact_phone
     */
    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    /**
     * 
     * @return
     *     The contactEmail
     */
    public String getContactEmail() {
        return contactEmail;
    }

    /**
     * 
     * @param contactEmail
     *     The contact_email
     */
    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    /**
     * 
     * @return
     *     The message
     */
    public String getMessage() {
        return message;
    }

    /**
     * 
     * @param message
     *     The message
     */
    public void setMessage(String message) {
        this.message = message;
    }

}
