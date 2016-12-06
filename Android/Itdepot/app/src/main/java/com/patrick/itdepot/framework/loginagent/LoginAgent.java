
package com.patrick.itdepot.framework.loginagent;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class LoginAgent {

    @SerializedName("agent_id")
    @Expose
    private String agentId;
    @SerializedName("agent_uniq_id")
    @Expose
    private String agentUniqId;
    @SerializedName("agent_name")
    @Expose
    private String agentName;
    @SerializedName("status")
    @Expose
    private String status;
    @SerializedName("created_at")
    @Expose
    private String createdAt;
    @SerializedName("updated_at")
    @Expose
    private String updatedAt;

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
     *     The agentName
     */
    public String getAgentName() {
        return agentName;
    }

    /**
     * 
     * @param agentName
     *     The agent_name
     */
    public void setAgentName(String agentName) {
        this.agentName = agentName;
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

}
