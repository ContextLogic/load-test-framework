local field = import 'lib/field.libsonnet';
local ad = import 'lib/groups/ad.json';
local pagerduty = import 'lib/groups/pagerduty.json';
local types = import 'lib/types.libsonnet';

{
	name: 'query_join_v2_shchen_test',
	owner_email: 'shchen@wish.com',
	team: ad.org_infra_platform.name,
	oncall: pagerduty['platform-services-coeus'].name,

	hive_table: 'search.query_join_v2_20220315140100',
	schedule: 'search.query_join_v2_20220315140100',
	key: field('time', types.INT),
	values: [
		field('query', types.STRING),
		field('tot_searches', types.INT),
		field('tot_searchers', types.INT),
		field('gmv_by_country', types.STRING),
		field('buyers_by_country', types.STRING),
	],
}