exec QBM_PTriggerDisable 'JobQueue', 'QBM_TUJobqueue'

-- Change queue of desired tasks
Update JobQueue 
set Queue = '\StathopoulosK'
where UID_Job in (
     Select top 5000 UID_Job 
     from JobQueue with (nolock) 
     where 1 = 1
       --and JobChainName in ('CCC_EventMgr_Schedule_TriggerDueEvents')
       --and Ready2EXE = 'TRUE'
       and Queue <> '\QBM_PWorkMaintenance' -- = '\<Old_JobQueue>'
     
      )

-- Set the system back to normal mode
exec QBM_PTriggerEnable 'JobQueue', 'QBM_TUJobqueue'