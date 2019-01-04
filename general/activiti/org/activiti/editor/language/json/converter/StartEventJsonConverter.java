/**
 * @(#)StartEventJsonConverter.java
 *
 * @author zhengziyong
 *
 * 版本历史
 * -------------------------------------------------------------------------
 * 时间 作者 内容
 * -------------------------------------------------------------------------
 * 2013-2-2 zhengziyong 创建版本
 */
package org.activiti.editor.language.json.converter;

import java.util.Map;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.ErrorEventDefinition;
import org.activiti.bpmn.model.Event;
import org.activiti.bpmn.model.EventDefinition;
import org.activiti.bpmn.model.FlowElement;
import org.activiti.bpmn.model.MessageEventDefinition;
import org.activiti.bpmn.model.SignalEventDefinition;
import org.activiti.bpmn.model.StartEvent;
import org.activiti.bpmn.model.TimerEventDefinition;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.ObjectNode;
/**
 * 
 * 
 * @author zhengziyong
 */
public class StartEventJsonConverter extends BaseBpmnJsonConverter {

	public static void fillTypes(Map<String, Class<? extends BaseBpmnJsonConverter>> convertersToBpmnMap,
		      Map<Class<? extends BaseElement>, Class<? extends BaseBpmnJsonConverter>> convertersToJsonMap) {
		    
		    fillJsonTypes(convertersToBpmnMap);
		    fillBpmnTypes(convertersToJsonMap);
		  }
		  
		  public static void fillJsonTypes(Map<String, Class<? extends BaseBpmnJsonConverter>> convertersToBpmnMap) {
		    convertersToBpmnMap.put(STENCIL_EVENT_START_NONE, StartEventJsonConverter.class);
		    convertersToBpmnMap.put(STENCIL_EVENT_START_TIMER, StartEventJsonConverter.class);
		    convertersToBpmnMap.put(STENCIL_EVENT_START_ERROR, StartEventJsonConverter.class);
		    convertersToBpmnMap.put(STENCIL_EVENT_START_MESSAGE, StartEventJsonConverter.class);
		    convertersToBpmnMap.put(STENCIL_EVENT_START_SIGNAL, StartEventJsonConverter.class);
		  }
		  
		  public static void fillBpmnTypes(Map<Class<? extends BaseElement>, Class<? extends BaseBpmnJsonConverter>> convertersToJsonMap) {
		    convertersToJsonMap.put(StartEvent.class, StartEventJsonConverter.class);
		  }
		  
		  protected String getStencilId(FlowElement flowElement) {
		    Event event = (Event) flowElement;
		    if (event.getEventDefinitions().size() > 0) {
		      EventDefinition eventDefinition = event.getEventDefinitions().get(0);
		      if (eventDefinition instanceof TimerEventDefinition) {
		        return STENCIL_EVENT_START_TIMER;
		      } else if (eventDefinition instanceof ErrorEventDefinition) {
		        return STENCIL_EVENT_START_ERROR;
		      } else if (eventDefinition instanceof MessageEventDefinition) {
		        return STENCIL_EVENT_START_MESSAGE;
		      } else if (eventDefinition instanceof SignalEventDefinition) {
		        return STENCIL_EVENT_START_SIGNAL;
		      } 
		    }
		    return STENCIL_EVENT_START_NONE;
		  }
		  
		  protected void convertElementToJson(ObjectNode propertiesNode, FlowElement flowElement) {
		    StartEvent startEvent = (StartEvent) flowElement;
		    if (StringUtils.isNotEmpty(startEvent.getInitiator())) {
		    	propertiesNode.put(PROPERTY_NONE_STARTEVENT_INITIATOR, startEvent.getInitiator());
		    }
		    addFormProperties(startEvent.getFormProperties(), propertiesNode);
		    addEventProperties(startEvent, propertiesNode);
		  }
		  
		  protected FlowElement convertJsonToElement(JsonNode elementNode, JsonNode modelNode, Map<String, JsonNode> shapeMap) {
		    StartEvent startEvent = new StartEvent();
		    startEvent.setInitiator(getPropertyValueAsString(PROPERTY_NONE_STARTEVENT_INITIATOR, elementNode));
		    String stencilId = BpmnJsonConverterUtil.getStencilId(elementNode);
		    if (STENCIL_EVENT_START_NONE.equals(stencilId)) {
		      startEvent.setFormKey(getPropertyValueAsString(PROPERTY_FORMKEY, elementNode));
		      convertJsonToFormProperties(elementNode, startEvent);
		    } else if (STENCIL_EVENT_START_TIMER.equals(stencilId)) {
		      convertJsonToTimerDefinition(elementNode, startEvent);
		    } else if (STENCIL_EVENT_START_ERROR.equals(stencilId)) {
		      convertJsonToErrorDefinition(elementNode, startEvent);
		    } else if (STENCIL_EVENT_START_MESSAGE.equals(stencilId)) {
		      convertJsonToMessageDefinition(elementNode, startEvent);
		    } else if (STENCIL_EVENT_START_SIGNAL.equals(stencilId)) {
		      convertJsonToSignalDefinition(elementNode, startEvent);
		    }
		    return startEvent;
		  }

}

