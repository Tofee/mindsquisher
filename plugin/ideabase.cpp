#include "ideabase.h"

IdeaBase::IdeaBase()
{

}

QString IdeaBase::text()
{
    return mText;
}

void IdeaBase::setText(QString iText)
{
    if(mText != iText) {
        mText = iText;
        textChanged();
    }
}
