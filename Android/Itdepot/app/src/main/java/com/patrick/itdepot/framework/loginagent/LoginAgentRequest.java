
package com.patrick.itdepot.framework.loginagent;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class LoginAgentRequest {

    @SerializedName("agent_uniq_id")
    @Expose
    private String agentUniqId;

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

}
