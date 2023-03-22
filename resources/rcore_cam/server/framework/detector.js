on('rcore:GetMainObject', (framework, resourceName, resolve) => {
    if (framework && framework.toLowerCase().trim() === 'esx') {
        try {
            resolve(exports[resourceName || 'es_extended']['getSharedObject']())
        } catch {
            let isResolved = false;
            emit('esx:getSharedObject', (object) => {
                resolve(object);
                isResolved = true;
            });

            setTimeout(() => {
                if (!isResolved) {
                    console.log('^1================ WARNING ================^7')
                    console.log('^7Failed to ^2load^7 shared object!^7')
                    console.log('^1================ WARNING ================^7')
                    resolve(undefined);
                }
            }, 100);
        }
    } else if (framework && framework.toLowerCase().trim() === 'qbcore') {
        try {
            resolve(exports[resourceName || 'qb-core']['GetCoreObject']())
        } catch {
            try {
                resolve(exports[resourceName || 'qb-core']['GetSharedObject']())
            } catch {
                let isResolved = false;
                emit('QBCore:GetObject', (object) => {
                    resolve(object);
                    isResolved = true;
                });

                setTimeout(() => {
                    if (!isResolved) {
                        console.log('^1================ WARNING ================^7')
                        console.log('^7Failed to ^2load^7 shared object!^7')
                        console.log('^1================ WARNING ================^7')
                        resolve(undefined);
                    }
                }, 100);
            }
        }
    } else {
        console.log('^1================ WARNING ================^7')
        console.log('^7Failed to ^2load^7 shared object!^7')
        console.log('^1================ WARNING ================^7')

        resolve(undefined)
    }
})
