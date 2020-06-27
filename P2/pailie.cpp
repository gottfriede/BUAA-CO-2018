#include<stdio.h>

int a[6],v[7];
int n;

void dfs(int x)
{
	if (x==n)
	{
		for (int i=0;i<n;i++)
			printf("%d ",a[i]);
		printf("\n");
	}
	for (int i=1;i<=n;i++)
		if(v[i]==0)
		{
			v[i]=1;
			a[x]=i;
			dfs(x+1);
			v[i]=0;
		}
}

int main()
{
	scanf("%d",&n);
	dfs(0);
	return 0;
}
