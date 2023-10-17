/**
 * @name Improper AWS Credentials
 * @kind problem
 * @problem.severity warning
 * @id javascript/actions/improper-aws-credentials
 * @tags actions
 *       security
 *       experimental
 */

 import javascript
 import semmle.javascript.Actions
 
 from string file, YamlNode accesskey, Actions::Workflow workflow,  Actions::Job job, Actions::Step step, Actions::Uses uses, Actions::With with
  where 
  exists(step.getUses()) and
  step.getUses() = uses and
  uses.getGitHubRepository() = "aws-actions/configure-aws-credentials" and
  step.getJob() = job and
  job.getWorkflow() = workflow and
  workflow.getFileName() = file and
  with.getStep() = step and
  with.lookup("aws-access-key-id") = accesskey
  select step, "AWS_ACCESS_KEY_ID used as AWS credential instead of OIDC in Action '" + uses.getGitHubRepository() + "' in step '$@' in file " + file, step, step.toString()