/*
 * Copyright (C) 2016 Christophe Chapuis <chris.chapuis@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

#include <QtQml>

#include "plugin.h"

#include "ideabase.h"
#include "line.h"
#include "qobjectlistmodel.h"

MindSquisherPlugin::MindSquisherPlugin(QObject *parent) :
	QQmlExtensionPlugin(parent)
{
}

void MindSquisherPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<Line>(uri, 1, 0, "Line");
    qmlRegisterType<QObjectListModel>(uri, 1, 0, "ObjectList");
    qmlRegisterType<IdeaBase>(uri, 1, 0, "IdeaBase");
}
