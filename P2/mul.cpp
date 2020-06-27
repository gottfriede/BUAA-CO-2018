#include<stdio.h>
int a[10][10],b[10][10];
int n;

int main()
{
	scanf("%d",&n);
	for (int i=0;i<n;i++)
		for (int j=0;j<n;j++)
			scanf("%d",&a[i][j]);
	for (int i=0;i<n;i++)
		for (int j=0;j<n;j++)
			scanf("%d",&b[i][j]);
			
	for (int i=0;i<n;i++)
	{
		for (int j=0;j<n;j++)
		{
			int ans=0;
			for (int k=0;k<n;k++)
				ans+=a[i][k]*b[k][j];
			printf("%d ",ans);
		}
		printf("\n");
	}
	return 0;
}
