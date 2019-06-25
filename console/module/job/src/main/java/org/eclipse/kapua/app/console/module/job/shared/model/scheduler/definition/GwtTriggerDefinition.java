/*******************************************************************************
 * Copyright (c) 2019 Eurotech and/or its affiliates and others
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     Eurotech - initial API and implementation
 *******************************************************************************/
package org.eclipse.kapua.app.console.module.job.shared.model.scheduler.definition;

import org.eclipse.kapua.app.console.module.api.shared.model.GwtEntityModel;
import org.eclipse.kapua.app.console.module.job.shared.model.scheduler.GwtTriggerProperty;

import java.util.List;

public class GwtTriggerDefinition extends GwtEntityModel {

    public enum GwtTriggerType {
        TIMER, EVENT
    }

    @Override
    public <X> X get(String property) {
        if ("triggerTypeEnum".equals(property)) {
            return (X) GwtTriggerType.valueOf(getTriggerType());
        } else {
            return super.get(property);
        }
    }

    public String getTriggerDefinitionName() {
        return get("triggerDefinitionName");
    }

    public void setTriggerDefinitionName(String triggerDefinitionName) {
        set("triggerDefinitionName", triggerDefinitionName);
    }

    public String getDescription() {
        return get("description");
    }

    public void setDescription(String description) {
        set("description", description);
    }

    public String getTriggerType() {
        return get("triggerType");
    }

    public GwtTriggerType getTriggerTypeEnum() {
        return get("triggerTypeEnum");
    }

    public void setTriggerType(String triggerType) {
        set("triggerType", triggerType);
    }

    public String getProcessorName() {
        return get("processorName");
    }

    public void setProcessorName(String processorName) {
        set("processorName", processorName);
    }

    public <P extends GwtTriggerProperty> List<P> getTriggerProperties() {
        return get("triggerProperties");
    }

    public void setTriggerProperties(List<GwtTriggerProperty> triggerProperties) {
        set("triggerProperties", triggerProperties);
    }
}
