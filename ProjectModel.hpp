#ifndef QMLTEST_PROJECT_MODEL_H
#define QMLTEST_PROJECT_MODEL_H
#include <QtQml>
#include <Project.hpp>
#include <ProjectContentProvider.hpp>
#include <DataListModelTemplate.hpp>

class ProjectModel : public DataListModelTemplate<Project>
{
    Q_OBJECT
    QML_ELEMENT
public:
    ProjectModel();
private slots:
    void fetch();
};

#endif // QMLTEST_PROJECT_MODEL_H
