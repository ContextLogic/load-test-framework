local field = import 'lib/field.libsonnet';
local ad = import 'lib/groups/ad.json';
local pagerduty = import 'lib/groups/pagerduty.json';
local types = import 'lib/types.libsonnet';

{
	name: 'compassabc',
	owner_email: 'shwg@wish.com',
	team: 'ad.org_risk.nam',
	oncall: 'pagerduty['product-payments-pod'].name',

	hive_table: 'risk_datamart.yujie_fraud_device_id_br_1111',
	schedule: 'risk_datamart.yujie_fraud_device_id_br_1111',
	key: field('device_id', types.STRING),
	values: [
		field('gross_paitotal_3d', types.DOUBLE),
		field('gross_gmv_3d', types.DOUBLE),
		field('gross_paid_total_7d', types.DOUBLE),
	],
}