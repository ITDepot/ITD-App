
package com.patrick.itdepot.framework.login;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class LoginRequest {

    @SerializedName("email_id")
    @Expose
    private String emailId;
    @SerializedName("phone")
    @Expose
    private String phone;

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
     *     The phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * 
     * @param phone
     *     The phone
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

}
