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
package org.eclipse.kapua.service.device.management.exception;

import org.eclipse.kapua.service.device.management.message.request.KapuaRequestMessage;

import javax.validation.constraints.NotNull;

/**
 * The {@link Exception} to throw when sending the {@link KapuaRequestMessage} causes an error.
 *
 * @since 1.1.0
 */
public class DeviceManagementSendException extends DeviceManagementException {

    private final KapuaRequestMessage requestMessage;

    /**
     * Constructor.
     *
     * @param requestMessage The {@link KapuaRequestMessage} that we tried to send.
     * @since 1.1.0
     */
    public DeviceManagementSendException(@NotNull KapuaRequestMessage requestMessage) {
        this(null, requestMessage);
    }

    /**
     * Constructor.
     *
     * @param cause          the root cause of the {@link Exception}.
     * @param requestMessage The {@link KapuaRequestMessage} that we tried to send.
     * @since 1.1.0
     */
    public DeviceManagementSendException(@NotNull Throwable cause, @NotNull KapuaRequestMessage requestMessage) {
        super(DeviceManagementErrorCodes.SEND_ERROR, cause, requestMessage);

        this.requestMessage = requestMessage;
    }

    /**
     * Gets the {@link KapuaRequestMessage} that we tried to send.
     *
     * @return The {@link KapuaRequestMessage} that we tried to send.
     * @since 1.1.0
     */
    public KapuaRequestMessage getRequestMessage() {
        return requestMessage;
    }
}
