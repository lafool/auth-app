/*
 * Copyright 2016 Red Hat, Inc. and/or its affiliates
 * and other contributors as indicated by the @author tags.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

 package org.keycloak.crypto.hash;

 import org.keycloak.Config;
 import org.keycloak.credential.hash.PasswordHashProvider;
 import org.keycloak.credential.hash.PasswordHashProviderFactory;
 import org.keycloak.models.KeycloakSession;
 import org.keycloak.models.KeycloakSessionFactory;
 
 /**
  * @author <a href="mailto:pro.guillaume.leroy@gmail.com">Guillaume Leroy</a>
  */
 public class BCryptPasswordHashProviderFactory implements PasswordHashProviderFactory {
     public static final String ID = "bcrypt";
     public static final int DEFAULT_ITERATIONS = 10;
 
     @Override
     public PasswordHashProvider create(KeycloakSession session) {
         return new BCryptPasswordHashProvider(ID, DEFAULT_ITERATIONS);
     }
 
     @Override
     public void init(Config.Scope config) {
     }
 
     @Override
     public void postInit(KeycloakSessionFactory factory) {
     }
 
     @Override
     public String getId() {
         return ID;
     }
 
     @Override
     public void close() {
     }
 }