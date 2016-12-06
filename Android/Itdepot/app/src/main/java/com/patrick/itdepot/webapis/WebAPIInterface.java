package com.patrick.itdepot.webapis;

import com.patrick.itdepot.framework.callme.CallMeResponse;
import com.patrick.itdepot.framework.contactclient.ContactClientResponse;
import com.patrick.itdepot.framework.getinstallpendding.GetInstallPenddingResponse;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurringResponse;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurringResponse;
import com.patrick.itdepot.framework.getquotes.GetQuotesResponse;
import com.patrick.itdepot.framework.isuservalid.IsUserValidResponse;
import com.patrick.itdepot.framework.login.LoginResponse;
import com.patrick.itdepot.framework.loginagent.LoginAgentResponse;
import com.patrick.itdepot.framework.register.RegisterResponse;
import com.patrick.itdepot.framework.sendquote.SendQuoteResponse;
import com.patrick.itdepot.framework.updateagent.UpdateAgentResponse;

import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.POST;

/**
 * Created by James P. Zimmerman II on 3/4/16.
 */
public interface WebAPIInterface {

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<LoginAgentResponse> login_agent(@Field("api_id") String api_id,
                                         @Field("api_secret") String api_secret,
                                         @Field("api_request") String api_request,
                                         @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<GetQuotesResponse> get_quotes(@Field("api_id") String api_id,
                                       @Field("api_secret") String api_secret,
                                       @Field("api_request") String api_request,
                                       @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<GetInstallPenddingResponse> get_install_pendding(@Field("api_id") String api_id,
                                                          @Field("api_secret") String api_secret,
                                                          @Field("api_request") String api_request,
                                                          @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<GetNonRecurringResponse> get_non_recurring_income(@Field("api_id") String api_id,
                                                           @Field("api_secret") String api_secret,
                                                           @Field("api_request") String api_request,
                                                           @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<GetMonthlyRecurringResponse> get_monthly_recurring_income(@Field("api_id") String api_id,
                                                                   @Field("api_secret") String api_secret,
                                                                   @Field("api_request") String api_request,
                                                                   @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<CallMeResponse> call_me(@Field("api_id") String api_id,
                                 @Field("api_secret") String api_secret,
                                 @Field("api_request") String api_request,
                                 @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<SendQuoteResponse> send_a_quote(@Field("api_id") String api_id,
                                         @Field("api_secret") String api_secret,
                                         @Field("api_request") String api_request,
                                         @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<ContactClientResponse> contact_the_client(@Field("api_id") String api_id,
                                                   @Field("api_secret") String api_secret,
                                                   @Field("api_request") String api_request,
                                                   @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<RegisterResponse> registration(@Field("api_id") String api_id,
                                        @Field("api_secret") String api_secret,
                                        @Field("api_request") String api_request,
                                        @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<LoginResponse> login(@Field("api_id") String api_id,
                              @Field("api_secret") String api_secret,
                              @Field("api_request") String api_request,
                              @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<UpdateAgentResponse> update_agent(@Field("api_id") String api_id,
                                           @Field("api_secret") String api_secret,
                                           @Field("api_request") String api_request,
                                           @Field("data") String data);

    @FormUrlEncoded
    @POST(Endpoint.POST_URL)
    Call<IsUserValidResponse> is_user_valid(@Field("api_id") String api_id,
                                            @Field("api_secret") String api_secret,
                                            @Field("api_request") String api_request,
                                            @Field("data") String data);



    class Endpoint {
       // public static final String POST_URL = "itdepot/api/api.php";
        public static final String POST_URL = "api/api.php";
    }
}
