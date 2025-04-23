workspace "Медикаменте" {

    !identifiers hierarchical

    model {
        
        properties {
            "structurizr.groupSeparator" "/"
        }
        
        patient = person "Пациент"
        
        patient_access_mark = softwareSystem  "HTTPS, двухфакторная аутентификация\nвсе действия логируются" {
                tags "BigLabel"
        }
        
        cassier = person "Кассир"
        
        doctor = person "Доктор"
        
        doctor_access_mark = softwareSystem  "доступ по роли к PHI только своих пациентов\nдвухфакторная аутентификация\nвсе действия логируются" {
                tags "BigLabel"
        }
        
        bookkeeper = person "Бухгалтер"
        
        bookkeeper_access_mark = softwareSystem  "VPN, доступ по роли, двухфакторная аутентификация" {
                tags "BigLabel"
        }
        
        warehouse_keeper = person "Сотрудник склада"
        
        warehouse_access_mark = softwareSystem  "VPN, доступ по роли + двухфакторная аутентификация" {
                tags "BigLabel"
        }
        
        administrator = person "Администратор"
        
        administrator_access_mark = softwareSystem  "доступ по роли к PII\nдвухфакторная аутентификация\nвсе действия логируются" {
                tags "BigLabel"
        }
        
        kmm = softwareSystem "Кассовые аппараты (KMM)"
        
        kmm_ipsec_mark = softwareSystem "IPsec" {
                tags "Label"
        }
        
        group "Медикаменте" {
        
            client_portal = softwareSystem "Портал для клиентов"
            
            client_portal_tls_mark = softwareSystem "TLS" {
                tags "Label"
            }
            
            reception_portal = softwareSystem "Портал для сотрудников ресепшена" 
            
            reception_portal_tls_mark = softwareSystem "TLS\n" {
                tags "Label"
            }
            
            crm_system = softwareSystem "CRM для сбора данных о клиентах"
            
            crm_system_pii_mark = softwareSystem "PII, PHI" {
                tags "Label"
            }
            
            crm_system_storage_mark = softwareSystem  "шифрование БД\nконтроль доступа\nаудит действий сотрудников\nудаление данных через 5 лет или по запросу клиента" {
                tags "BigLabel"
            }
            
            accounting_1c = softwareSystem "1С Бухгалтерия предприятия" "[1С, PostgreSQL]"
            
            accounting_1c_storage_mark = softwareSystem  "шифрование БД\nконтроль доступа\nаудит действий сотрудников\nудаление данных через 5 лет" {
                tags "BigLabel"
            }
            
            warehouse_1c = softwareSystem "1С Торговля и склад" "[1С, PostgreSQL ]"
            
            warehouse_1c_storage_mark = softwareSystem  "шифрование БД\nконтроль доступа\nаудит действий сотрудников\nудаление данных через 3 года" {
                tags "BigLabel"
            }
        
        }
        
        # Связи
        
        patient -> cassier "Оплачивает услуги через кассира"
        
        cassier -> kmm "Пробивает чек через кассовый аппарат"
        
        kmm -> accounting_1c "Передаёт данные о платеже в бухгалтерию"
        
        patient -> client_portal "Записывается на приём, просматривает личные данные"
        
        client_portal -> crm_system "Отправляет данные о пациентах и визитах"
        
        administrator -> reception_portal "Регистрирует пациентов и управляет записями"
        
        reception_portal -> crm_system "Сохраняет информацию о пациентах и визитах"
        
        doctor -> reception_portal "Получает доступ к расписанию приёмов и картам пациентов и редактирует медицинскую карту пациента"
        
        bookkeeper -> accounting_1c "Управляет бухгалтерией и расчётами"
        
        warehouse_keeper -> warehouse_1c "Управляет складскими запасами медикаментов"
        
        warehouse_1c -> accounting_1c
        accounting_1c -> warehouse_1c 
    }
    
    views {
        systemLandscape main "auto" {
            include *
        }
        
        styles {
            element "Element" {
                background #008cba
                color #ffffff
                shape RoundedBox
            }
            element "IsComment" {
                background white
                color black
                metadata false
                shape RoundedBox
            }
            element "Label" {
                background white
                color black
                stroke green
                metadata false
                width 150
                height 150
                shape RoundedBox
            }
            element "BigLabel" {
                background white
                color black
                stroke green
                metadata false
                width 450
                height 300
                shape RoundedBox
            }
            element "Person" {
                background #05527d
                shape person
            }
            element "Software System" {
                background #066296
            }
            element "Database" {
                shape cylinder
            }
            element "Queue" {
                shape pipe
            }
            relationship "Relationship" {
                style solid
                routing Curved
            }
        }
    }

}
