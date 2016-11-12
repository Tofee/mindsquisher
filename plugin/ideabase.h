#ifndef IDEABASE_H
#define IDEABASE_H

#include <QQuickItem>

class IdeaBase : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    IdeaBase();

    QString text();
    void setText(QString iText);

signals:
    void textChanged();

public slots:

private:
    QString mText;
};

#endif // IDEABASE_H
