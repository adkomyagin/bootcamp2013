   st1 = db.serverStatus();
   sleep(1000*sampleSecs);
   st2 = db.serverStatus();

   statsDoc =
   {
       'flushes': st2.backgroundFlushing.flushes - st1.backgroundFlushing.flushes,
       'flushes_ms': st2.backgroundFlushing.total_ms - st1.backgroundFlushing.total_ms,
       'globalLockTotalTime': st2.globalLock.totalTime - st1.globalLock.totalTime,
       'globalLockLockTime': st2.globalLock.lockTime - st1.globalLock.lockTime,
       'indexAccesses': st2.indexCounters.accesses - st1.indexCounters.accesses,
       'indexHits': st2.indexCounters.hits - st1.indexCounters.hits,
       'indexMisses': st2.indexCounters.misses - st1.indexCounters.misses,
       'locksTimeLockedR': st2.locks['.'].timeLockedMicros.R - st1.locks['.'].timeLockedMicros.R,
       'locksTimeLockedW': st2.locks['.'].timeLockedMicros.W - st1.locks['.'].timeLockedMicros.W,
       'locksTimeAquiringR': st2.locks['.'].timeAcquiringMicros.R - st1.locks['.'].timeAcquiringMicros.R,
       'locksTimeAquiringW': st2.locks['.'].timeAcquiringMicros.W - st1.locks['.'].timeAcquiringMicros.W,
       'networkBytesIn': st2.network.bytesIn - st1.network.bytesIn,
       'networkBytesOut': st2.network.bytesOut - st1.network.bytesOut,
       'networkNumRequests': st2.network.numRequests - st1.network.numRequests,
       'opcounterInsert': st2.opcounters.insert - st1.opcounters.insert,
       'opcounterQuery': st2.opcounters.query - st1.opcounters.query,
       'opcounterUpdate': st2.opcounters.update - st1.opcounters.update,
       'opcounterDelete': st2.opcounters.delete - st1.opcounters.delete,
       'opcounterGetmore': st2.opcounters.getmore - st1.opcounters.getmore,
       'opcounterCommand': st2.opcounters.command - st1.opcounters.command,
       'recordAccessNotInMem': st2.recordStats.accessesNotInMemory - st1.recordStats.accessesNotInMemory,
       'recordPageFaultExcpt': st2.recordStats.pageFaultExceptionsThrown - st1.recordStats.pageFaultExceptionsThrown,
       'metricsDocsDeleted': st2.metrics.document.deleted - st1.metrics.document.deleted,
       'metricsDocsInserted': st2.metrics.document.inserted - st1.metrics.document.inserted,
       'metricsDocsReturned': st2.metrics.document.returned - st1.metrics.document.returned,
       'metricsDocsScanned': st2.metrics.document.scanned - st1.metrics.document.scanned,
       'metricsDocsUpdated': st2.metrics.document.updated - st1.metrics.document.updated,
       'metricsOpsFastmod': st2.metrics.operation.fastmod - st1.metrics.operation.fastmod,
       'metricsOpsIdhack': st2.metrics.operation.idhack - st1.metrics.operation.idhack,
       'metricsOpsScanAndOrder': st2.metrics.operation.scanAndOrder - st1.metrics.operation.scanAndOrder,
       'metricsRecordMoves': st2.metrics.record.moves - st1.metrics.record.moves
   }

   printjson(statsDoc)

   // Saving to mongodb because Server bug in 2.3.2 was keeping shell output from being captured   
   db.mongoPeriodStats.insert({'_id': testName, 'sampleSecs': sampleSecs, testResults: statsDoc},{upsert: true});

quit();

