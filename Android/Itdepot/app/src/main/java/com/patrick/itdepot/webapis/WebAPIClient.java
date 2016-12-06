package com.patrick.itdepot.webapis;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.patrick.itdepot.framework.callme.CallMeRequest;
import com.patrick.itdepot.framework.callme.CallMeResponse;
import com.patrick.itdepot.framework.contactclient.ContactClientRequest;
import com.patrick.itdepot.framework.contactclient.ContactClientResponse;
import com.patrick.itdepot.framework.getinstallpendding.GetInstallPenddingRequest;
import com.patrick.itdepot.framework.getinstallpendding.GetInstallPenddingResponse;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurringRequest;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurringResponse;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurringRequest;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurringResponse;
import com.patrick.itdepot.framework.getquotes.GetQuotesRequest;
import com.patrick.itdepot.framework.getquotes.GetQuotesResponse;
import com.patrick.itdepot.framework.isuservalid.IsUserValidRequest;
import com.patrick.itdepot.framework.isuservalid.IsUserValidResponse;
import com.patrick.itdepot.framework.login.LoginRequest;
import com.patrick.itdepot.framework.login.LoginResponse;
import com.patrick.itdepot.framework.loginagent.LoginAgentRequest;
import com.patrick.itdepot.framework.loginagent.LoginAgentResponse;
import com.patrick.itdepot.framework.register.RegisterRequest;
import com.patrick.itdepot.framework.register.RegisterResponse;
import com.patrick.itdepot.framework.sendquote.SendQuoteRequest;
import com.patrick.itdepot.framework.sendquote.SendQuoteResponse;
import com.patrick.itdepot.framework.updateagent.UpdateAgentRequest;
import com.patrick.itdepot.framework.updateagent.UpdateAgentResponse;

import java.security.cert.CertificateException;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Callback;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by James P. Zimmerman II on 3/4/16.
 */
public class WebAPIClient {
    private static final String TAG = WebAPIClient.class.getSimpleName();
    private Retrofit jsonClient;

   // public static String baseUrl = "http://iroid-apps.com/iroidtest/";
    public static String baseUrl = "http://35.165.32.210/";
    private final String api_id = "0ccb6e042ce192fbe28d0ffc86f50e40";
    private final String api_secret = "0754ed5cb5cf73d4bda6d3296950c2c5";

    public WebAPIClient(Retrofit jsonClient) {
        this.jsonClient = jsonClient;
    }

    public static WebAPIClient getInstance(Context c) {
        OkHttpClient.Builder builder = new OkHttpClient().newBuilder();
        builder.readTimeout(60, TimeUnit.MINUTES);
        builder.connectTimeout(60, TimeUnit.MINUTES);

        HttpLoggingInterceptor logging = new HttpLoggingInterceptor();
        logging.setLevel(HttpLoggingInterceptor.Level.BODY);
        builder.addInterceptor(logging);

        fixSSL(builder);
        OkHttpClient httpClient = builder.build();

        Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();

        Retrofit json = new Retrofit.Builder()
                .baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())
                .client(httpClient)
                .build();
        WebAPIClient webAPIClient = new WebAPIClient(json);
        return webAPIClient;
    }

    public static void fixSSL(OkHttpClient.Builder builder) {
        final TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    @Override
                    public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) throws CertificateException {
                    }

                    @Override
                    public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) throws CertificateException {
                    }

                    @Override
                    public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                        return new java.security.cert.X509Certificate[]{};
                    }
                }
        };
        final SSLContext sslContext;
        try {
            sslContext = SSLContext.getInstance("SSL");
            sslContext.init(null, trustAllCerts, new java.security.SecureRandom());
            final SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();
            builder.sslSocketFactory(sslSocketFactory);
            builder.hostnameVerifier(new HostnameVerifier() {
                @Override
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private WebAPIInterface json() {
        return jsonClient.create(WebAPIInterface.class);
    }

    //1----------------------login_agent-----------------------------------------------------------------
    public void login_agent(LoginAgentRequest loginAgentRequest, Callback<LoginAgentResponse> callback) {
        String api_request = "login_agent";
        String data = new Gson().toJson(loginAgentRequest);
        json().login_agent(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //2----------------------get_quotes-----------------------------------------------------------------
    public void get_quotes(GetQuotesRequest getQuotesRequest, Callback<GetQuotesResponse> callback) {
        String api_request = "get_quotes";
        String data = new Gson().toJson(getQuotesRequest);
        json().get_quotes(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //3----------------------get_install_pendding-----------------------------------------------------------------
    public void get_install_pendding(GetInstallPenddingRequest getInstallPenddingRequest, Callback<GetInstallPenddingResponse> callback) {
        String api_request = "get_install_pendding";
        String data = new Gson().toJson(getInstallPenddingRequest);
        json().get_install_pendding(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //4----------------------get_non_recurring_income-----------------------------------------------------------------
    public void get_non_recurring_income(GetNonRecurringRequest getNonRecurringRequest, Callback<GetNonRecurringResponse> callback) {
        String api_request = "get_non_recurring_income";
        String data = new Gson().toJson(getNonRecurringRequest);
        json().get_non_recurring_income(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //5----------------------get_monthly_recurring_income-----------------------------------------------------------------
    public void get_monthly_recurring_income(GetMonthlyRecurringRequest getMonthlyRecurringRequest, Callback<GetMonthlyRecurringResponse> callback) {
        String api_request = "get_monthly_recurring_income";
        String data = new Gson().toJson(getMonthlyRecurringRequest);
        json().get_monthly_recurring_income(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //6----------------------call_me-----------------------------------------------------------------
    public void call_me(CallMeRequest callMeRequest, Callback<CallMeResponse> callback) {
        String api_request = "call_me";
        String data = new Gson().toJson(callMeRequest);
        json().call_me(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //7----------------------send_a_quote-----------------------------------------------------------------
    public void send_a_quote(SendQuoteRequest sendQuoteRequest, Callback<SendQuoteResponse> callback) {
        String api_request = "send_a_quote";
        String data = new Gson().toJson(sendQuoteRequest);
        json().send_a_quote(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //8----------------------contact_the_client-----------------------------------------------------------------
    public void contact_the_client(ContactClientRequest contactClientRequest, Callback<ContactClientResponse> callback) {
        String api_request = "contact_the_client";
        String data = new Gson().toJson(contactClientRequest);
        json().contact_the_client(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //9----------------------registration-----------------------------------------------------------------
    public void registration(RegisterRequest registerRequest, Callback<RegisterResponse> callback) {
        String api_request = "registration";
        String data = new Gson().toJson(registerRequest);
        json().registration(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //10----------------------login-----------------------------------------------------------------
    public void login(LoginRequest loginRequest, Callback<LoginResponse> callback) {
        String api_request = "login";
        String data = new Gson().toJson(loginRequest);
        json().login(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //11----------------------update_agent-----------------------------------------------------------------
    public void update_agent(UpdateAgentRequest updateAgentRequest, Callback<UpdateAgentResponse> callback) {
        String api_request = "update_agent";
        String data = new Gson().toJson(updateAgentRequest);
        json().update_agent(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //12----------------------is_user_valid-----------------------------------------------------------------
    public void is_user_valid(IsUserValidRequest isUserValidRequest, Callback<IsUserValidResponse> callback) {
        String api_request = "is_user_valid";
        String data = new Gson().toJson(isUserValidRequest);
        json().is_user_valid(api_id, api_secret, api_request, data).enqueue(callback);
    }

    //----------------------------------------------------------------------------------------------

}
