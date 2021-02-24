#include "RoundImage.hpp"
#include <QPainter>
#include <QNetworkReply>

RoundImage::RoundImage(QQuickItem* parent)
: QQuickPaintedItem(parent)
{
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
    setPerformanceHint(QQuickPaintedItem::FastFBOResizing, true);
}

void RoundImage::paint(QPainter* painter)
{    
    if (!_image_ptr.isNull())
    {
        QPen pen;
        pen.setStyle(Qt::NoPen);
        painter->setPen(pen);

        QBrush brush(*_image_ptr);

        brush.setTransform(QTransform{}.scale(width() / _image_ptr->width(), height() / _image_ptr->height()));
        painter->setBrush(brush);
        painter->drawRoundedRect(QRectF(0, 0, width(), height()), width() / 2, height() / 2);
    }
}

void RoundImage::doAsyncPaint(const QUrl& url, QSharedPointer<QImage> image)
{
    QPointer<QNetworkAccessManager> manager { new QNetworkAccessManager };
    auto reply = manager->get(QNetworkRequest { url });
    auto onFinished = [=]
    {
        if (reply->error() == QNetworkReply::NoError && image->loadFromData(reply->readAll())) {
            _image_ptr = image;
            update();
        } else
            qCritical() << "Failed to read an image from path" << _source;
        manager->deleteLater();
    };
    auto onError = [](QNetworkReply::NetworkError code)
    {
        qCritical() << "Error code" << code;
    };
    QObject::connect(reply, &QNetworkReply::finished, this, onFinished);
    QObject::connect(reply, &QNetworkReply::errorOccurred, this, onError);
}

QString RoundImage::source() const
{
    return _source;
}

void RoundImage::setSource(QString source)
{
    if (_source == source) return;

    _source = std::move(source);
    emit sourceChanged(_source);

    QUrl url(_source);
    QSharedPointer<QImage> image { new QImage };
    auto scheme = url.scheme();

    if (
            (scheme == "qrc" && image->load(_source.sliced(3))) // results in resource ref without scheme
            || ((scheme.isEmpty() || url.isLocalFile()) && image->load(url.path()))
    ) {
        _image_ptr = image;
        update();
    } else
        doAsyncPaint(std::move(url), image);
}
