define([
    'dojo/_base/declare',
    'dojo/topic'
], function (declare, topic) {
    return declare('dime.event.eventManager', [], {
        handles: {},
        subscribe: function(eventTopic, subTopic, subscriberId, func){
            this.handles[subscriberId+'/'+eventTopic+'/'+subTopic] = topic.subscribe(eventTopic+'/'+subTopic, func);
        },

        fire: function(eventTopic, subTopic, argument){
            topic.publish(eventTopic+'/'+subTopic, argument || null);
        },

        unsubscribe: function(eventTopic, subTopic, subscriberId){
            this.handles[subscriberId+'/'+eventTopic+'/'+subTopic].remove();
        }
    });
});