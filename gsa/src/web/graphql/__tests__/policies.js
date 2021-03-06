/* Copyright (C) 2021 Greenbone Networks GmbH
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
/* eslint-disable react/prop-types */
import React from 'react';

import {rendererWith, fireEvent, screen, wait} from 'web/utils/testing';

import {
  createClonePolicyQueryMock,
  createDeletePoliciesByIdsQueryMock,
  createExportPoliciesByIdsQueryMock,
  createGetPolicyQueryMock,
} from '../__mocks__/policies';
import {
  useClonePolicy,
  useDeletePolicy,
  useExportPoliciesByIds,
  useGetPolicy,
} from '../policies';

const GetPolicyComponent = ({id}) => {
  const {loading, policy, error} = useGetPolicy(id);
  if (loading) {
    return <span data-testid="loading">Loading</span>;
  }
  return (
    <div>
      {error && <div data-testid="error">{error.message}</div>}
      {policy && (
        <div data-testid="policy">
          <span data-testid="id">{policy.id}</span>
          <span data-testid="name">{policy.name}</span>
        </div>
      )}
    </div>
  );
};

describe('useGetPolicy tests', () => {
  test('should load policy', async () => {
    const [queryMock, resultFunc] = createGetPolicyQueryMock();

    const {render} = rendererWith({queryMocks: [queryMock]});

    render(<GetPolicyComponent id="234" />);

    expect(screen.queryByTestId('loading')).toBeInTheDocument();

    await wait();

    expect(resultFunc).toHaveBeenCalled();

    expect(screen.queryByTestId('loading')).not.toBeInTheDocument();
    expect(screen.queryByTestId('error')).not.toBeInTheDocument();

    expect(screen.getByTestId('policy')).toBeInTheDocument();

    expect(screen.getByTestId('id')).toHaveTextContent('234');
    expect(screen.getByTestId('name')).toHaveTextContent('unnamed policy');
  });
});

const ExportPoliciesByIdsComponent = () => {
  const exportPoliciesByIds = useExportPoliciesByIds();
  return (
    <button
      data-testid="bulk-export"
      onClick={() => exportPoliciesByIds(['234'])}
    />
  );
};

describe('useExportPoliciesByIds tests', () => {
  test('should export a list of policys after user interaction', async () => {
    const [mock, resultFunc] = createExportPoliciesByIdsQueryMock(['234']);
    const {render} = rendererWith({queryMocks: [mock]});

    render(<ExportPoliciesByIdsComponent />);
    const button = screen.getByTestId('bulk-export');
    fireEvent.click(button);

    await wait();

    expect(resultFunc).toHaveBeenCalled();
  });
});

const DeletePolicyComponent = () => {
  const [deletePolicy] = useDeletePolicy();
  return <button data-testid="delete" onClick={() => deletePolicy('234')} />;
};

describe('useDeletePoliciesByIds tests', () => {
  test('should delete a list of policys after user interaction', async () => {
    const [mock, resultFunc] = createDeletePoliciesByIdsQueryMock(['234']);
    const {render} = rendererWith({queryMocks: [mock]});

    render(<DeletePolicyComponent />);
    const button = screen.getByTestId('delete');
    fireEvent.click(button);

    await wait();

    expect(resultFunc).toHaveBeenCalled();
  });
});

const ClonePolicyComponent = () => {
  const [clonePolicy, {id: policyId}] = useClonePolicy();
  return (
    <div>
      {policyId && <span data-testid="cloned-policy">{policyId}</span>}
      <button data-testid="clone" onClick={() => clonePolicy('234')} />
    </div>
  );
};

describe('useClonePolicy tests', () => {
  test('should clone a policy after user interaction', async () => {
    const [mock, resultFunc] = createClonePolicyQueryMock('234', '345');
    const {render} = rendererWith({queryMocks: [mock]});

    render(<ClonePolicyComponent />);

    const button = screen.getByTestId('clone');
    fireEvent.click(button);

    await wait();

    expect(resultFunc).toHaveBeenCalled();

    expect(screen.getByTestId('cloned-policy')).toHaveTextContent('345');
  });
});
