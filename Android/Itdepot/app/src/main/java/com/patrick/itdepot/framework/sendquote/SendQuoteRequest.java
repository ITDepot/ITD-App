
package com.patrick.itdepot.framework.sendquote;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class SendQuoteRequest {

    @SerializedName("agent_uniq_id")
    @Expose
    private String agentUniqId;
    @SerializedName("agent_id")
    @Expose
    private String agentId;
    @SerializedName("service")
    @Expose
    private String service;
    @SerializedName("business_name")
    @Expose
    private String businessName;
    @SerializedName("street_address")
    @Expose
    private String streetAddress;
    @SerializedName("city")
    @Expose
    private String city;
    @SerializedName("state")
    @Expose
    private String state;
    @SerializedName("zip")
    @Expose
    private String zip;
    @SerializedName("message")
    @Expose
    private String message;

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
     *     The streetAddress
     */
    public String getStreetAddress() {
        return streetAddress;
    }

    /**
     * 
     * @param streetAddress
     *     The street_address
     */
    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    /**
     * 
     * @return
     *     The city
     */
    public String getCity() {
        return city;
    }

    /**
     * 
     * @param city
     *     The city
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * 
     * @return
     *     The state
     */
    public String getState() {
        return state;
    }

    /**
     * 
     * @param state
     *     The state
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * 
     * @return
     *     The zip
     */
    public String getZip() {
        return zip;
    }

    /**
     * 
     * @param zip
     *     The zip
     */
    public void setZip(String zip) {
        this.zip = zip;
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
