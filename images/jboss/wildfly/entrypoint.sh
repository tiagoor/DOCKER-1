#!/bin/bash
JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}
function wait_for_server() {
until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
sleep 1
done
}
echo "=> Starting JBoss..."
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG > /dev/null &
wait_for_server
echo "=> Executando commands.cli..."
$JBOSS_CLI -c --file=/tmp/commands.cli
echo "=> Add Admin User"
/opt/jboss/wildfly/bin/add-user.sh admin admin --silent

echo "=> Stopping o JBoss..."
if [ "$JBOSS_MODE" = "standalone" ]; then
$JBOSS_CLI -c ":shutdown"
else
$JBOSS_CLI -c "/host=*:shutdown"
fi


echo "=> Restarting Jboss"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -bmanagement 0.0.0.0 
