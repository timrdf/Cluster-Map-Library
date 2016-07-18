#!/bin/sh

cd "`dirname "${0}"`/.."
CMV_HOME=.

for i in ${CMV_HOME}/lib/*.jar
do
  # if the directory is empty, then it will return the input string
  # this is stupid, so case for it
  if [ -f "$i" ] ; then
    if [ -z "$LOCALCLASSPATH" ] ; then
      LOCALCLASSPATH="$i"
    else
      LOCALCLASSPATH="$i":"$LOCALCLASSPATH"
    fi
  fi
done

                                                                                                                                     
if [ -z "${CMV_JAVA_OPTS}" ] ; then
  CMV_JAVA_OPTS="-Xmx96M"
  echo "Using default CMV_JAVA_OPTS: ${CMV_JAVA_OPTS}"
fi


if [ "`uname`" = "Darwin" ] ; then

  echo "MacOS X detected"
  echo ""
  echo "Welcome, Mac users, and enjoy the power of Aduna Cluster Maps!"
  echo ""

  if [ "`which java`" = "" ] ; then
    echo "Sorry, 'java' is not found in your path."
    echo ""
    echo "If you have a default installation of MacOS X, please contact support@aduna.biz!"
    echo "Otherwise, correct your path to properly include 'java' again."
    echo ""
  else
    java ${CMV_JAVA_OPTS} -Dapple.laf.useScreenMenuBar=true -Xdock:name="Aduna Cluster Map Viewer" -classpath ${LOCALCLASSPATH} biz.aduna.map.cluster.ClusterMapViewer
  fi

else

  ${JAVA_HOME}/bin/java ${CMV_JAVA_OPTS} -classpath ${LOCALCLASSPATH} biz.aduna.map.cluster.ClusterMapViewer

fi
