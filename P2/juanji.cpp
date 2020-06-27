#include<stdio.h>

int a[10][10],b[10][10];
int n1,m1,n2,m2;

int main()
{
	scanf("%d %d %d %d",&n1,&m1,&n2,&m2);
	for (int i=0;i<n1;i++)
		for (int j=0;j<m1;j++)
			scanf("%d",&a[i][j]);
	for (int i=0;i<n2;i++)
		for (int j=0;j<m2;j++)
			scanf("%d",&b[i][j]);
	
	for (int i=0;i<=n1-n2;i++)
	{
		for (int j=0;j<=m1-m2;j++)
		{
			int ans=0;
			for (int k=0;k<n2;k++)
				for (int l=0;l<m2;l++)
					ans+=a[i+k][j+l]*b[k][l];
			printf("%d ",ans);
		}
		printf("\n");
	}
	return 0;
}
