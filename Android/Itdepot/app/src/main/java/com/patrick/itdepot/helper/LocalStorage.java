package com.patrick.itdepot.helper;

import android.content.Context;

public class LocalStorage {

    public static String SHRARED_PREF_FILE_NAME = "My@ItdepotApp";
    public static String agent_id = "agent_id";
    public static String agent_uniq_id = "agent_uniq_id";
    public static String agent_name = "agent_name";
    public static String status = "status";
    public static String created_at = "created_at";
    public static String updated_at = "updated_at";
    public static String IS_LOGIN_FIRST_TIME = "IS_LOGIN_FIRST_TIME";

    public static String user_id = "user_id";
    public static String firstname = "firstname";
    public static String lastname = "lastname";
    public static String email_id = "email_id";
    public static String phone = "phone";
    public static String company = "company";
    public static String street = "street";
    public static String suite = "suite";
    public static String city = "city";
    public static String state = "state";
    public static String zip = "zip";

    public static String this_month_income = "this_month_income";
    public static String monthly_reccuring = "monthly_reccuring";

    private Context context;

    public LocalStorage(Context context) {
        this.context = context;
    }

    public void PutItem(String Key, String Value) {
        try {
            context.getSharedPreferences(SHRARED_PREF_FILE_NAME, 0).edit().putString(Key, Value).commit();
        } catch (Exception e) {
        }
    }

    public void RemoveItem(String Key) {
        try {
            context.getSharedPreferences(SHRARED_PREF_FILE_NAME, 0).edit().remove(Key).commit();
        } catch (Exception e) {
        }
    }

    public String GetItem(String Key) {
        try {
            return context.getSharedPreferences(SHRARED_PREF_FILE_NAME, 0).getString(Key, "");
        } catch (Exception e) {
            return "";
        }
    }

    public void Clear() {
        try {
            context.getSharedPreferences(SHRARED_PREF_FILE_NAME, 0).edit().clear().commit();
        } catch (Exception e) {
        }
    }

}
