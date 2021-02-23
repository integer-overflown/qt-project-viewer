#include <ProjectModel.hpp>
#include <ProjectContentProvider.hpp>

void ProjectModel::setToken(const QString& token)
{
    qDebug() << _token << token;
    if (token == _token)
        return;
    qDebug() << "set";
    emit tokenChanged(token);

    QPointer<ProjectContentProvider> provider { new ProjectContentProvider(token) };
    QObject::connect(provider, &ProjectContentProvider::success, [=](QList<Project> projectList){
        beginInsertRows(QModelIndex{}, 0, projectList.size());
        modelData = std::move(projectList);
        endInsertRows();
        qDebug() << "just got" << modelData.size() << "pretty new items";
        emit dataChanged(createIndex(0, 0), createIndex(modelData.size(), 0), { Qt::DisplayRole });
        provider->deleteLater();
    });
}

int ProjectModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return modelData.size();
}

QHash<int, QByteArray> ProjectModel::roleNames() const
{
    qDebug() << "names";
    static const QHash<int, QByteArray> value = {
        { Name, "name" },
        { Icon, "icon" }
    };
    return value;
}

QVariant ProjectModel::data(const QModelIndex& index, int role) const
{
    qDebug() << "data" << index << role;
    switch (role) {
    case Name:
        return QVariant::fromValue(modelData[index.row()].name);
    case Icon:
        qDebug() << modelData[index.row()].icon ;
        return QVariant::fromValue(modelData[index.row()].icon);
    default: return QVariant();
    }
}
