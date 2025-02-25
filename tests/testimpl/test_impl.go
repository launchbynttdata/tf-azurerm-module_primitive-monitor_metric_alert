package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	armMetric "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/monitor/armmonitor"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestMetricAlertsModule(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	armMetricAlertsClient, err := armMetric.NewMetricAlertsClient(subscriptionId, credential, &options)
	if err != nil {
		t.Fatalf("Error getting Metric Alerts client: %v", err)
	}

	t.Run("doesMetricAlertsExist", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		metricAlertsName := terraform.Output(t, ctx.TerratestTerraformOptions(), "monitor_metric_alert_name")

		metricAlerts, err := armMetricAlertsClient.Get(context.Background(), resourceGroupName, metricAlertsName, nil)
		if err != nil {
			t.Fatalf("Error getting MetricAlerts: %v", err)
		}

		assert.Equal(t, metricAlertsName, *metricAlerts.Name)
	})
}
