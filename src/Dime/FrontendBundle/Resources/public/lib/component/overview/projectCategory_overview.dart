part of entity_overview;

@Component(
		selector: 'projectCategory-overview',
		templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/projectCategory_overview.html',
		useShadowDom: false
)
class ProjectCategoryOverviewComponent extends EntityOverview {
	ProjectCategoryOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
	super(ProjectCategory, store, '', manager, status, auth: auth);

	cEnt({ProjectCategory entity}) {
		if (entity != null) {
			return new ProjectCategory.clone(entity);
		}
		return new ProjectCategory();
	}

}