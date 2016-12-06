package com.patrick.itdepot.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;


import com.patrick.itdepot.R;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurring;

import java.util.List;

/**
 * Created by iroid on 8/24/2016.
 */
public class AdapterNonRecurring extends ArrayAdapter {

    private Context context;
    private List<GetNonRecurring> objects;

    public AdapterNonRecurring(Context context, int resource, List objects) {
        super(context, resource, objects);
        this.context = context;
        this.objects = objects;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder vh = null;
        if (convertView == null) {
            vh = new ViewHolder();
            convertView = LayoutInflater.from(context).inflate(R.layout.cell_non_reccuring_income, null);

            vh.lblClientNr = (TextView) convertView.findViewById(R.id.lblClientNr);
            vh.lblServicesNr = (TextView) convertView.findViewById(R.id.lblServicesNr);
            vh.lblNrIncome = (TextView) convertView.findViewById(R.id.lblNrIncome);
            vh.lblDataPaid = (TextView) convertView.findViewById(R.id.lblDataPaid);

            convertView.setTag(vh);
        } else {
            vh = (ViewHolder) convertView.getTag();
        }

        vh.lblClientNr.setText(objects.get(position).getClientName());
        vh.lblServicesNr.setText(objects.get(position).getService());
        vh.lblNrIncome.setText(objects.get(position).getNrIncome());
        vh.lblDataPaid.setText(objects.get(position).getDatePaid());

        return convertView;

    }

    private class ViewHolder {
        TextView lblClientNr;
        TextView lblServicesNr;
        TextView lblNrIncome;
        TextView lblDataPaid;
    }
}
