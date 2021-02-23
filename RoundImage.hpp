#ifndef QMLTEST_ROUNDED_IMAGE_H
#define QMLTEST_ROUNDED_IMAGE_H
#include <QtQuick/QQuickPaintedItem>
#include <QSharedPointer>

class RoundImage : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    QML_ELEMENT
public:
    explicit RoundImage(QQuickItem* parent = nullptr);
    void paint(QPainter*) override;
    [[nodiscard]] QString source() const;
public slots:
    void setSource(QString);
signals:
    void sourceChanged(const QString&);
private:
    void doAsyncPaint(const QUrl&, QSharedPointer<QImage>);
private:
    QString _source;
    QSharedPointer<QImage> _image_ptr;
};

#endif //QMLTEST_ROUNDED_IMAGE_H
