local field = import 'lib/field.libsonnet';
local ad = import 'lib/groups/ad.json';
local pagerduty = import 'lib/groups/pagerduty.json';
local types = import 'lib/types.libsonnet';

{
	name: 'coeus_feature_store_dev_shchen_test_9_query_join_0318',
	owner_email: 'shchen@wish.com',
	team: ad.org_infra_platform.name,
	oncall: pagerduty['platform-services-coeus'].name,

	hive_table: 'search.query_join_v2_20220318140101',
	partition_fields: [],
	schedule: 'hourly',
	key: field('query', types.STRING),
	values: [
		field('time', types.INT),
		field('tot_searches', types.INT),
		field('tot_searchers', types.INT),
		field('gmv_by_country', types.STRING),
		field('buyers_by_country', types.STRING),
	],
}