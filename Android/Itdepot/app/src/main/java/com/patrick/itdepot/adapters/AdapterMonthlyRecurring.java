package com.patrick.itdepot.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurring;

import java.util.List;


public class AdapterMonthlyRecurring extends ArrayAdapter<GetMonthlyRecurring> {

    private Context context;
    private List<GetMonthlyRecurring> objects;

    public AdapterMonthlyRecurring(Context context, int resource, List<GetMonthlyRecurring> objects) {
        super(context, resource, objects);
        this.context = context;
        this.objects = objects;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder vh = null;
        if (convertView == null) {
            vh = new ViewHolder();
            convertView = LayoutInflater.from(context).inflate(R.layout.cell_monthly_reccuring_income, null);

            vh.lblClientMonthly = (TextView) convertView.findViewById(R.id.lblClientMonthly);
            vh.lblServicesMonthly = (TextView) convertView.findViewById(R.id.lblServicesMonthly);
            vh.lblMrIncome = (TextView) convertView.findViewById(R.id.lblMrIncome);
            vh.lblDataStarted = (TextView) convertView.findViewById(R.id.lblDataStarted);

            convertView.setTag(vh);
        } else {
            vh = (ViewHolder) convertView.getTag();
        }
        vh.lblClientMonthly.setText(objects.get(position).getClientName());
        vh.lblServicesMonthly.setText(objects.get(position).getService());
        vh.lblMrIncome.setText(objects.get(position).getMrIncome());
        vh.lblDataStarted.setText(objects.get(position).getDateStarted());

        return convertView;
    }

    private class ViewHolder {
        TextView lblClientMonthly;
        TextView lblServicesMonthly;
        TextView lblMrIncome;
        TextView lblDataStarted;

    }
}
