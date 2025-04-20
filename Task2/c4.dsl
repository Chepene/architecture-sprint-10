workspace "Медикаменте" {

    !identifiers hierarchical

    model {
        
        properties {
            "structurizr.groupSeparator" "/"
        }
        
        patient = person "Пациент"
        
        cassier = person "Кассир"
        
        doctor = person "Доктор"
        
        bookkeeper = person "Бухгалтер"
        
        warehouse_keeper = person "Сотрудник склада"
        
        administrator = person "Администратор"
        
        group "Медикаменте" {
        
            client_portal = softwareSystem "Портал для клиентов"
            
            reception_portal = softwareSystem "Портал для сотрудников ресепшена"
            
            crm_system = softwareSystem "CRM для сбора данных о клиентах"
            
            accounting_1c = softwareSystem "1С Бухгалтерия предприятия" "[1С, файловый режим]"
            
            warehouse_1c = softwareSystem "1С Торговля и склад" "[1С, файловый режим]"
            
            kmm = softwareSystem "Кассовые аппараты (KMM)"
        
        }
        
        # Связи
        
        patient -> cassier "Оплачивает услуги через кассира"
        
        cassier -> kmm "Пробивает чек через кассовый аппарат"
        
        kmm -> accounting_1c "Передаёт данные о платеже в бухгалтерию"
        
        patient -> client_portal "Записывается на приём, просматривает личные данные"
        
        client_portal -> crm_system "Отправляет данные о пациентах и визитах"
        
        administrator -> reception_portal "Регистрирует пациентов и управляет записями"
        
        reception_portal -> crm_system "Сохраняет информацию о пациентах и визитах"
        
        doctor -> reception_portal "Получает доступ к расписанию приёмов и картам пациентов"
        
        doctor -> crm_system "Обновляет медицинскую информацию пациентов"
        
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
