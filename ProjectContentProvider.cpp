#include <ProjectContentProvider.hpp>
#include <private/Credentials.hpp>

ProjectContentProvider::ProjectContentProvider(const QString& token, QObject* parent)
: QObject(parent), ContentProvider<Project>("projects", token, api::projects)
{}

Project ProjectContentProvider::handleNextObject(const QJsonObject& o) const
{
    return Project{ o["id"].toInt(), o["name"].toString(), o["icon"].toString() };
}

void ProjectContentProvider::ready(ProjectContentProvider::Data data)
{
    emit success(std::move(data));
}
