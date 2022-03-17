local field = import 'lib/field.libsonnet';
local ad = import 'lib/groups/ad.json';
local pagerduty = import 'lib/groups/pagerduty.json';
local types = import 'lib/types.libsonnet';

{
	name: 'coeus_feature_store_dev_shchen_test_user_data_shchen_2',
	owner_email: 'shchen@wish.com',
	team: ad.org_infra_platform.name,
	oncall: pagerduty['platform-services-coeus'].name,

	hive_table: 'core_storage.user_data_service_test',
	partition_fields: [],
	schedule: 'hourly',
	key: field('_id', types.STRING),
	values: [
		field('fb_uid', types.STRING),
		field('gender', types.STRING),
		field('gender_inferred', types.STRING),
		field('location_name', types.STRING),
		field('locale', types.STRING),
		field('timezone_offset', types.STRING),
		field('name', types.STRING),
	],
}