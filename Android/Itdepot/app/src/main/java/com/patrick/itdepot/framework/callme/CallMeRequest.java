
package com.patrick.itdepot.framework.callme;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class CallMeRequest {

    @SerializedName("user_id")
    @Expose
    private String userId;
    @SerializedName("service")
    @Expose
    private String service;
    @SerializedName("cell_number")
    @Expose
    private String cellNumber;
    @SerializedName("email_id")
    @Expose
    private String emailId;
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
     *     The cellNumber
     */
    public String getCellNumber() {
        return cellNumber;
    }

    /**
     * 
     * @param cellNumber
     *     The cell_number
     */
    public void setCellNumber(String cellNumber) {
        this.cellNumber = cellNumber;
    }

    /**
     * 
     * @return
     *     The emailId
     */
    public String getEmailId() {
        return emailId;
    }

    /**
     * 
     * @param emailId
     *     The email_id
     */
    public void setEmailId(String emailId) {
        this.emailId = emailId;
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
