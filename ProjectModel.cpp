#include <ProjectModel.hpp>

ProjectModel::ProjectModel()
: DataListModelTemplate<Project>("project")
{
    // further token changes won't be tracked
    QObject::connect(this, &ProjectModel::tokenChanged, this, &ProjectModel::fetch, Qt::SingleShotConnection);
}

void ProjectModel::fetch()
{
    QPointer provider { new ProjectContentProvider(_token) };
    QObject::connect(provider, &ProjectContentProvider::success, [=](auto projectList){
        setData(projectList);
        provider->deleteLater();
    });
}
