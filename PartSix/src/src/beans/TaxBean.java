package beans;

import java.io.IOException;
import java.io.Serializable;

public class TaxBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private double taxValue = 0.0;
	private double moneySum = 0.0;
	private double baseValue = 0.0;

	private String moneySumString = "0.0";
	private String baseValueString = "0.0";

	private final double[] percents = new double[] { 9.0, 15.0, 20.0, 25.0, 30.0 };
	private final double[] moneysInBase = new double[] { 240.0, 600.0 - 240.0, 840.0 - 600.0, 1080.0 - 840.0, 0.0 };

	public String getMoneySumString() {
		return moneySumString;
	}

	public void setMoneySumString(String moneySumString) {
		this.moneySumString = moneySumString;
		try {
			moneySum = Double.parseDouble(moneySumString);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public String getBaseValueString() {
		return baseValueString;
	}

	public void setBaseValueString(String baseValueString) {
		this.baseValueString = baseValueString;
		try {
			baseValue = Double.parseDouble(baseValueString);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public TaxBean() {
	}

	public double getTaxValue() {
		calculate();
		return taxValue;
	}

	private void calculate() {
		double moneySumBase = (baseValue > 0 ? moneySum / baseValue : 0.0  );
		double tmpTax = 0.0;
		for (int i = 0; i < moneysInBase.length; i++) {
			
			double tmpVal = moneysInBase[i];
			double perc  = percents[i];
			if(moneySumBase - tmpVal > 0.0 && tmpVal > 0.0) {
				tmpTax += (tmpVal * perc) / 100.0;
				moneySumBase-= tmpVal;
			}else {				
				tmpTax += ((moneySumBase) * perc) / 100.0;
				break;
			}
		}
		
		
		this.taxValue = tmpTax * baseValue;
	}
}
