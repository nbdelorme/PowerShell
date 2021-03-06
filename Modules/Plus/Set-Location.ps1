function Set-Location {
	[CmdletBinding(DefaultParameterSetName='Path', SupportsTransactions=$true, HelpUri='http://go.microsoft.com/fwlink/?LinkID=113397')]
	param(
		[Parameter(ParameterSetName='Path', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
		[string]
		${Path},

		[Parameter(ParameterSetName='LiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
		[Alias('PSPath')]
		[string]
		${LiteralPath},

		[switch]
		${PassThru},

		[Parameter(ParameterSetName='Stack', ValueFromPipelineByPropertyName=$true)]
		[string]
		${StackName})

	begin
	{
		try {
			$outBuffer = $null
			if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
			{
				$PSBoundParameters['OutBuffer'] = 1
			}
			$wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Set-Location', [System.Management.Automation.CommandTypes]::Cmdlet)
			$scriptCmd = {& $wrappedCmd @PSBoundParameters }
			$steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
			$steppablePipeline.Begin($PSCmdlet)
		} catch {
			throw
		}
	}

	process
	{
        [void](New-Variable -Name PreviousLocation -Value $((Get-Location).Path) -Scope Global -Force -ea SilentlyContinue)
		$back = (Get-Location).Path
		try {
			$steppablePipeline.Process($_)
		} catch {
			throw
		}
	}

	end
	{
		try {
			$steppablePipeline.End()
		} catch {
			throw
		}
	}
	<#

	.ForwardHelpTargetName Set-Location
	.ForwardHelpCategory Cmdlet

	#>
}
