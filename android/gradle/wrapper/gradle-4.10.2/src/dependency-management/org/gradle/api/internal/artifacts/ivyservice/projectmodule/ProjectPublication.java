/*
 * Copyright 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.api.internal.artifacts.ivyservice.projectmodule;

import org.gradle.api.internal.component.SoftwareComponentInternal;
import org.gradle.internal.DisplayName;

import javax.annotation.Nullable;

/**
 * Provides information about an external publication of a project.
 */
public interface ProjectPublication {
    DisplayName getDisplayName();

    /**
     * Returns the coordinates of the publication in the given namespace.
     */
    @Nullable
    <T> T getCoordinates(Class<T> type);

    @Nullable
    SoftwareComponentInternal getComponent();

    /**
     * Specifies that this publication is just an alias for another one and should not
     * be considered when converting project dependencies to published metadata.
     */
    boolean isAlias();

    /**
     * Should this publication be ignored when there are others available?
     */
    boolean isLegacy();
}
